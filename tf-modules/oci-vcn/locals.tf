locals {
  ADs = [
    for i in data.oci_identity_availability_domains.ad.availability_domains : i.name
  ]
  core_image    = element(data.oci_core_images.ubuntu_image.images, 0)
  core_image_id = local.core_image.id
}
