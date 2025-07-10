output "instance_ip_addresses" {
  value = oci_core_instance.core_instance[*].public_ip
}
