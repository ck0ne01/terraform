resource "oci_core_network_security_group" "load_balancer" {
  count = var.instance_count == 1 ? 0 : 1

  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id

  display_name = "${var.instance_display_name}-security-group"
}

resource "oci_core_network_security_group_security_rule" "load_balancer_security_rule" {
  count = var.instance_count == 1 ? 0 : 1

  network_security_group_id = oci_core_network_security_group.load_balancer[0].id
  direction                 = "INGRESS"
  protocol                  = "6"

  destination = var.network_cidr_block

  source      = "0.0.0.0/0"
  source_type = "CIDR_BLOCK"
  # stateless   = var.network_security_group_security_rule_stateless
  tcp_options {

    destination_port_range {
      max = 6443
      min = 6443
    }
    source_port_range {
      max = 6443
      min = 6443
    }
  }
}

resource "oci_load_balancer_load_balancer" "this" {
  count = var.instance_count == 1 ? 0 : 1

  compartment_id = oci_identity_compartment.compartment.id
  display_name   = "${var.instance_display_name}-load-balancer"
  shape          = "flexible"
  subnet_ids     = [oci_core_subnet.subnet.id]

  network_security_group_ids = [oci_core_network_security_group.load_balancer[0].id]

  shape_details {
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }
}

resource "oci_load_balancer_backend_set" "this" {
  count = var.instance_count == 1 ? 0 : 1

  health_checker {
    protocol = "TCP"
  }

  load_balancer_id = oci_load_balancer_load_balancer.this[0].id
  name             = "${var.instance_display_name}-backend"
  policy           = "LEAST_CONNECTIONS"
}

resource "oci_load_balancer_backend" "api_server" {
  for_each = var.instance_count == 1 ? {} : local.instance_backends

  backendset_name  = oci_load_balancer_backend_set.this[0].name
  ip_address       = each.value
  load_balancer_id = oci_load_balancer_load_balancer.this[0].id
  port             = 6443
}

resource "oci_load_balancer_listener" "test_listener" {
  count = var.instance_count == 1 ? 0 : 1

  default_backend_set_name = oci_load_balancer_backend_set.this[0].name
  load_balancer_id         = oci_load_balancer_load_balancer.this[0].id
  name                     = "${var.instance_display_name}-listener"
  port                     = 6443
  protocol                 = "TCP"

  # hostname_names = [var.instance_display_name]
}
