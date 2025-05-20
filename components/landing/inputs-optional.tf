variable "existing_purview_account" {
  description = "Details of an existing purview account to use, if not specified a new one will be created."
  type = object({
    resource_id                              = string
    managed_storage_account_id               = optional(string)
    managed_event_hub_namespace_id           = optional(string)
    self_hosted_integration_runtime_auth_key = optional(string)
    identity = object({
      principal_id = string
      tenant_id    = string
    })
  })
  default = null
}
# Azure Monitor
variable "install_azure_monitor" {
  description = "Install Azure Monitor Agent."
  type        = bool
  default     = false
}

variable "systemassigned_identity" {
  description = "Assign System identity"
  type        = bool
  default     = false
}

variable "f5_subscription_id" {
  description = "The subscription ID for the F5 VPN."
  type        = string
  default     = "ed302caf-ec27-4c64-a05e-85731c3ce90e"
}
