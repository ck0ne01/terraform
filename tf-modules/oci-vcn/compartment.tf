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

