resource "oci_core_vcn" "vcn" {
  compartment_id = oci_identity_compartment.compartment.id

  cidr_blocks  = tolist([var.network_cidr_block])
  display_name = "${var.instance_display_name}_vcn"
  dns_label    = var.dns_label
}

resource "oci_core_security_list" "security_list" {
  compartment_id = oci_identity_compartment.compartment.id
  display_name   = "${var.instance_display_name}_security_list"
  vcn_id         = oci_core_vcn.vcn.id

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      max = 22
      min = 22
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      max = 8000
      min = 8000
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      max = 6001
      min = 6001
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      max = 80
      min = 80
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      max = 443
      min = 443
    }
  }

  ingress_security_rules {
    protocol = "1"
    source   = "0.0.0.0/0"
    icmp_options {
      code = 4
      type = 3
    }
  }

  ingress_security_rules {
    protocol = "1"
    source   = var.network_cidr_block
    icmp_options {
      type = 3
    }
  }

  ingress_security_rules {
    protocol = "1"
    source   = var.network_cidr_block
    icmp_options {
      code = 0
      type = 8
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.network_cidr_block
  }

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}

resource "oci_core_subnet" "subnet" {
  cidr_block        = element(oci_core_vcn.vcn.cidr_blocks, 0)
  compartment_id    = oci_identity_compartment.compartment.id
  vcn_id            = oci_core_vcn.vcn.id
  security_list_ids = tolist([oci_core_security_list.security_list.id])
  dns_label         = var.dns_label
}

resource "oci_core_internet_gateway" "internet_gateway" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  freeform_tags  = { "Department" = "Finance" }
}

resource "oci_core_route_table" "route_table" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  route_rules {
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
}

resource "oci_core_route_table_attachment" "route_table_attachment" {
  subnet_id      = oci_core_subnet.subnet.id
  route_table_id = oci_core_route_table.route_table.id
}

