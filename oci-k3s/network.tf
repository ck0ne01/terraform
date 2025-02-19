resource "oci_core_vcn" "k3s_vcn" {
  compartment_id = oci_identity_compartment.k3s_compartment.id

  cidr_blocks  = tolist(["10.0.0.0/24"])
  display_name = "${var.instance_display_name}_vcn"
}

resource "oci_core_subnet" "k3s_subnet" {
  cidr_block     = element(oci_core_vcn.k3s_vcn.cidr_blocks, 0)
  compartment_id = oci_identity_compartment.k3s_compartment.id
  vcn_id         = oci_core_vcn.k3s_vcn.id
}
