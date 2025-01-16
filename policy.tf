resource "random_uuid" "this" {}

resource "spacelift_policy" "msteams-integration" {
  name     = "MS Teams Integration (${var.channel_name}) <${random_uuid.this.result}>"
  type     = "NOTIFICATION"
  space_id = var.space_id

  body   = file("${path.module}/assets/policy.rego")
  labels = ["msteams"]
}
