locals {
  network_cidr_block = "10.0.0.0/24"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../tf-modules/oci-vcn"
}

inputs = {
  dns_label               = "k3s"
  instance_display_name   = "k3s"
  compartment_name        = "k3s"
  compartment_description = "k3s environment"
  instance_count          = 2

  root_compartment_id = "ocid1.tenancy.oc1..aaaaaaaabrdgmvt2eupbxwpiyznezqfreah3jrwedwdbrm7pndk63djrevia"
  user_ocid = "ocid1.user.oc1..aaaaaaaa5342v3y4h223poyqrpqgmnr2bj73d2aaa3sq6ho5jmr6rhahkjqa"
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaabrdgmvt2eupbxwpiyznezqfreah3jrwedwdbrm7pndk63djrevia"
  region = "eu-frankfurt-1"
  ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOoDrv30JNlMsxE5iK7bsLTf4NGFGCMtMsFmhDq+hD01 christian.kirmse@macbook-104"
}
