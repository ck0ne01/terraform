locals {
  ADs               = data.oci_identity_availability_domains.ad.availability_domains[*].name
  core_image        = element(data.oci_core_images.ubuntu_image.images, 0)
  core_image_id     = local.core_image.id
  instance_backends = { for i in oci_core_instance.core_instance : i.display_name => i.private_ip }
}
