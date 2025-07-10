resource "oci_budget_budget" "free_budget" {
  amount         = 1
  compartment_id = oci_identity_compartment.compartment.compartment_id
  reset_period   = "MONTHLY"
  description    = "free forever zero costs"
  display_name   = "free_forever"
  freeform_tags  = { "Department" = "Finance" }
  target_type    = "COMPARTMENT"
  targets        = tolist([oci_identity_compartment.compartment.id])
}

resource "oci_budget_alert_rule" "test_alert_rule" {
  budget_id      = oci_budget_budget.free_budget.id
  threshold      = 1
  threshold_type = "PERCENTAGE"
  type           = "FORECAST"
  defined_tags   = { "Operations.CostCenter" = "42" }
  description    = "free forever zero costs"
  display_name   = "free_forever"
  message        = "Cost Forecast exceeded"
  recipients     = "mailanck@me.com"
}
