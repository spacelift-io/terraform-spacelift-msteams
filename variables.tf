variable "channel_name" {
  type        = string
  description = "MS Teams channel name to send notifications to. This is just used for naming purposes."
}

variable "space_id" {
  type        = string
  description = "ID of the Spacelift space to create notitications for."
  default     = "root"
}

variable "webhook_url" {
  type        = string
  description = "URL of the MS Teams channel incoming webhook connector to send notifications to."
  sensitive   = true
}

variable "spacelift_url" {
  type        = string
  description = "URL of the Spacelift instance to use. (default: app.spacelift.io)"
  default     = "app.spacelift.io"
  // If the value is not app.spacelift.io, then we expect https or http to be provided
  validation {
    condition     = var.spacelift_url == "app.spacelift.io" || can(regex("^(https|http)://", var.spacelift_url))
    error_message = "spacelift_url must be either app.spacelift.io or a valid URL starting with http:// or https://"
  }
  // Value must not contain a trailing slash
  validation {
    condition     = !can(regex(".*/$", var.spacelift_url))
    error_message = "spacelift_url must not contain a trailing slash"
  }
}

locals {
  is_custom_spacelift_url = var.spacelift_url != "app.spacelift.io"
}