resource "oci_identity_compartment" "compartment" {
  compartment_id = var.root_compartment_id
  description    = var.compartment_description
  name           = var.compartment_name
}

data "oci_identity_availability_domains" "ad" {
  compartment_id = oci_identity_compartment.compartment.id
}

data "oci_core_images" "ubuntu_image" {
  compartment_id           = oci_identity_compartment.compartment.id
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "24.04 Minimal aarch64"
  shape                    = "VM.Standard.A1.Flex"
  state                    = "AVAILABLE"
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

locals {
  ADs = [
    for i in data.oci_identity_availability_domains.ad.availability_domains : i.name
  ]
  core_image    = element(data.oci_core_images.ubuntu_image.images, 0)
  core_image_id = local.core_image.id
}
