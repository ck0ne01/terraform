output "instance_ip_addresses" {
  value = oci_core_instance.core_instance[*].public_ip
}

output "load_balancer_ip_address" {
  value = try(oci_load_balancer_load_balancer.this[0].ip_address_details, "")
}
