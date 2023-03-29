terraform {
  required_providers {
    spacelift = {
      source = "spacelift-io/spacelift"
    }
  }
}


provider "spacelift" {}

variable "spacelift_run_id" {}

module "msteams-integration" {
  source = "../../"

  channel_name = var.spacelift_run_id
  space_id     = "public-modules-01GVNH2CJKSKHRSMDPBMQ3WZT9"
  webhook_url  = "https://devnull-as-a-service.com/dev/null"
}
