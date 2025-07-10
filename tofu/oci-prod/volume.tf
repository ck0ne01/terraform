# resource "oci_core_volume_backup_policy" "this" {
#   compartment_id = oci_identity_compartment.compartment.id
#
#   destination_region = var.region
#   display_name       = "${var.instance_display_name}_volume_backup_policy"
#   schedules {
#     backup_type       = "Incremental"
#     period            = "ONE_DAY"
#     retention_seconds = 172800
#     hour_of_day       = 04
#     time_zone         = "REGIONAL_DATA_CENTER_TIME"
#   }
# }

resource "oci_core_volume" "this" {
  count = var.instance_count

  compartment_id      = oci_identity_compartment.compartment.id
  availability_domain = element(local.ADs, count.index)
  defined_tags        = { "Service" = var.instance_display_name }
  display_name        = var.instance_display_name == "" ? "" : var.instance_count != 1 ? "${var.instance_display_name}_${count.index + 1}_volume" : "${var.instance_display_name}_volume"
  size_in_gbs         = (200 - var.instance_count * 47) / var.instance_count
}

# resource "oci_core_volume_backup_policy_assignment" "this" {
#   count = var.instance_count
#
#   asset_id  = oci_core_volume.this[count.index].id
#   policy_id = oci_core_volume_backup_policy.this.id
# }

resource "oci_core_volume_attachment" "this" {
  count = var.instance_count

  attachment_type = "Paravirtualized"
  instance_id     = oci_core_instance.core_instance[count.index].id
  volume_id       = oci_core_volume.this[count.index].id
}
