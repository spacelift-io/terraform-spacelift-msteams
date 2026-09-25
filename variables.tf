variable "channel_name" {
  type        = string
  description = "MS Teams channel name to send notifications to. This is just used for naming purposes."
}

variable "notification_policy_filepath" {
  type        = string
  description = "Path to a custom notification policy file. Defaults to the policy bundled with this module."
  default     = null
  nullable    = true
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
