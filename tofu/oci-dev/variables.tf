variable "root_compartment_id" {
  type = string
}

variable "compartment_description" {
  type    = string
  default = "Prod Environment"
}

variable "compartment_name" {
  type    = string
  default = "prod_env"
}

variable "user_ocid" {
  type = string
}

variable "fingerprint" {
  type = string
}

variable "tenancy_ocid" {
  type = string
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
  default = "coolify"
}

variable "assign_public_ip" {
  type    = bool
  default = true
}

variable "instance_cpu" {
  type    = number
  default = 4
}

variable "instance_memoty" {
  type    = number
  default = 24
}

variable "ssh_public_key" {
  type = string
}

variable "network_cidr_block" {
  type    = string
  default = "10.0.0.0/24"
}
