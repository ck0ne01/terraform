terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "6.26.0"
    }
  }
  required_version = ">= 1.10.5"

  cloud {
    organization = "ck0ne"
    workspaces {
      name = "oracle-k3s"
    }
  }
}

provider "oci" {
  user_ocid    = var.user_ocid
  tenancy_ocid = var.tenancy_ocid
  fingerprint  = var.fingerprint
  region       = var.region
  private_key  = var.private_key
}
