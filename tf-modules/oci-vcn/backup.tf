# resource "oci_core_volume_backup_policy" "this" {
#   compartment_id = oci_identity_compartment.compartment.id
#
#   destination_region = var.region
#   display_name       = "${var.instance_display_name}_volume_backup_policy"
#   schedules {
#     backup_type       = "FULL"
#     period            = "ONE_WEEK"
#     retention_seconds = 604800
#     hour_of_day       = 02
#     time_zone         = "REGIONAL_DATA_CENTER_TIME"
#   }
#
#   schedules {
#     backup_type       = "Incremental"
#     period            = "ONE_DAY"
#     retention_seconds = 172800
#     hour_of_day       = 04
#     time_zone         = "REGIONAL_DATA_CENTER_TIME"
#   }
# }
#
# resource "oci_core_volume_backup_policy_assignment" "this" {
#   count = var.instance_count
#
#   asset_id  = oci_core_volume.this[count.index].id
#   policy_id = oci_core_volume_backup_policy.this.id
# }
