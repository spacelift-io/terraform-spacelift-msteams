resource "spacelift_policy" "msteams-integration" {
  name     = "MS Teams Integration (${var.channel_name})"
  type     = "NOTIFICATION"
  space_id = var.space_id

  body   = file("${path.module}/assets/policy.rego")
  labels = ["msteams"]
}
