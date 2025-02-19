variable "root_compartment_id" {
  type    = string
  default = "ocid1.tenancy.oc1..aaaaaaaabrdgmvt2eupbxwpiyznezqfreah3jrwedwdbrm7pndk63djrevia"
}

variable "compartment_description" {
  type    = string
  default = "K3s Kubernetes Cluster"
}

variable "compartment_name" {
  type    = string
  default = "k3s_cluster"
}

variable "user_ocid" {
  type    = string
  default = "ocid1.user.oc1..aaaaaaaa5342v3y4h223poyqrpqgmnr2bj73d2aaa3sq6ho5jmr6rhahkjqa"
}

variable "fingerprint" {
  type    = string
  default = "d0:30:a5:f5:2a:37:bf:a2:66:0e:e7:28:a3:d2:4d:32"
}

variable "tenancy_ocid" {
  type    = string
  default = "ocid1.tenancy.oc1..aaaaaaaabrdgmvt2eupbxwpiyznezqfreah3jrwedwdbrm7pndk63djrevia"
}

variable "region" {
  type    = string
  default = "eu-frankfurt-1"
}

variable "private_key" {
  type = string
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "instance_shape" {
  type    = string
  default = "VM.Standard.A1.Flex"
}

variable "instance_display_name" {
  type    = string
  default = "k3s_node"
}

variable "assign_public_ip" {
  type    = bool
  default = true
}

variable "instance_cpu" {
  type    = number
  default = 2
}

variable "instance_memoty" {
  type    = number
  default = 12
}
