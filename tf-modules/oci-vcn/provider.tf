terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 7.9.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.5.0"
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
