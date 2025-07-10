terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 6.26.0"
    }
  }
  cloud {

    organization = "ck0ne"
    hostname     = "app.terraform.io"

    workspaces {
      name = "oci_prod"
    }
  }
  required_version = ">= 1.10.1"
}

provider "oci" {
  user_ocid    = var.user_ocid
  tenancy_ocid = var.tenancy_ocid
  fingerprint  = var.fingerprint
  region       = var.region
  private_key  = var.private_key
}
