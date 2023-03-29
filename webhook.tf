resource "spacelift_named_webhook" "msteams-integration" {
  name     = "MS Teams Integration (${var.channel_name})"
  space_id = var.space_id

  endpoint = var.webhook_url
  enabled  = true

  labels = ["msteams"]
}
