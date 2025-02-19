include "root" {
  path = find_in_parent_folders("root.hcl")
  }

terraform {
  source = "../../tf-modules/oci-vcn"
}

inputs = {
  dns_label               = "prod"
  instance_display_name   = "coolify"
  compartment_name        = "prod_env"
  compartment_description = "Prod Environment"
  instance_count          = 1
  
    ingress_rules = [
    {
      protocol = "6"
      source   = "0.0.0.0/0"
        tcp_options = {
          max = 443
          min = 443
      }
    },
    {
      protocol = "6"
      source   = "0.0.0.0/0"
      tcp_options = {
        max = 80
        min = 80
      }
    },
    {
      protocol = "6"
      source   = "0.0.0.0/0"
      tcp_options = {
        max = 6001
        min = 6001
      }
    }
  ]

  root_compartment_id = "ocid1.tenancy.oc1..aaaaaaaafhirbrdg7ejlpunuzfrndjjacnq6aherdusyvcrytu2ohw7wrclq"
  user_ocid = "ocid1.user.oc1..aaaaaaaauipb74lmta5mneouqjomaznmpthztojgalo4nqjdr33kqrukyuza"
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaafhirbrdg7ejlpunuzfrndjjacnq6aherdusyvcrytu2ohw7wrclq"
  region = "eu-frankfurt-1"
  ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOoDrv30JNlMsxE5iK7bsLTf4NGFGCMtMsFmhDq+hD01 christian.kirmse@macbook-104"
}
