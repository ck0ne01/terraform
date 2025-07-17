resource "oci_core_instance" "core_instance" {
  count = var.instance_count

  availability_domain = element(local.ADs, count.index)
  compartment_id      = oci_identity_compartment.compartment.id
  display_name        = var.instance_display_name == "" ? "" : var.instance_count != 1 ? "${var.instance_display_name}-${count.index + 1}" : var.instance_display_name
  shape               = var.instance_shape
  shape_config {
    memory_in_gbs = floor(var.instance_memory / var.instance_count)
    ocpus         = floor(var.instance_cpu / var.instance_count)
  }

  create_vnic_details {
    hostname_label   = var.instance_display_name == "" ? "" : var.instance_count != 1 ? "${var.instance_display_name}-${count.index + 1}" : var.instance_display_name
    display_name     = var.instance_display_name == "" ? "" : var.instance_count != 1 ? "${var.instance_display_name}-${count.index + 1}-vnic" : "${var.instance_display_name}-vnic"
    assign_public_ip = var.assign_public_ip
    subnet_id        = oci_core_subnet.subnet.id
  }

  source_details {
    source_id               = local.core_image_id
    source_type             = "image"
    boot_volume_size_in_gbs = floor(200 / var.instance_count) # 200 GB in always free tier
  }

  metadata             = tomap({ "ssh_authorized_keys" = var.ssh_public_key })
  preserve_boot_volume = false
}

