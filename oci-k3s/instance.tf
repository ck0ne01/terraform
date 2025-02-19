resource "oci_core_instance" "k3s_instance" {
  count = var.instance_count

  availability_domain = element(local.ADs, count.index)
  compartment_id      = oci_identity_compartment.k3s_compartment.id
  display_name        = var.instance_display_name == "" ? "" : var.instance_count != 1 ? "${var.instance_display_name}_${count.index + 1}" : var.instance_display_name
  shape               = var.instance_shape
  shape_config {
    memory_in_gbs = var.instance_memoty
    ocpus         = var.instance_cpu
  }

  create_vnic_details {
    display_name     = var.instance_display_name == "" ? "" : var.instance_count != 1 ? "${var.instance_display_name}_${count.index + 1}_vnic" : "${var.instance_display_name}_vnic"
    assign_public_ip = var.assign_public_ip
    subnet_id        = oci_core_subnet.k3s_subnet.id
  }

  source_details {
    source_id   = local.core_image_id
    source_type = "image"
  }
  preserve_boot_volume = false
}
