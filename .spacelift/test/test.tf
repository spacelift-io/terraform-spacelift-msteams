terraform {
  required_providers {
    spacelift = {
      source = "spacelift-io/spacelift"
    }
  }
}


provider "spacelift" {}

variable "spacelift_run_id" {}
variable "spacelift_space_id" {}

variable "spacelift_url" {
  type    = string
  default = "app.spacelift.io"
}

module "msteams-integration" {
  source = "../../"

  channel_name = var.spacelift_run_id
  space_id     = var.spacelift_space_id
  webhook_url  = "https://devnull-as-a-service.com/dev/null"
  spacelift_url = var.spacelift_url
}
