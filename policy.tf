resource "spacelift_policy" "msteams-integration" {
  name     = "MS Teams Integration (${var.channel_name})"
  type     = "NOTIFICATION"
  space_id = var.space_id

  body   = local.is_custom_spacelift_url ? local.custom_policy : local.default_policy
  labels = ["msteams"]
}

locals {
  default_policy = file("${path.module}/assets/policy.rego")
  custom_policy  = templatefile("${path.module}/assets/policy-custom.rego", {
    spacelift_url = var.spacelift_url
  })
}
