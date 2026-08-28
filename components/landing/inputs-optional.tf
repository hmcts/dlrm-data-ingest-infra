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

variable "smb_mount_monitor_alert" {
  description = "Existing Azure Monitor resources used for the SMB mount failure scheduled-query alert. The Log Analytics Workspace is referenced from the landing-zone module output for the given landing_zone_key; if resource_group_name is not set the alert is deployed to the Log Analytics Workspace's resource group. Supply the existing Action Group and alert resource-group details. computer_name must match the syslog Computer field of the VM running the smb-mount-monitor service."
  type = object({
    enabled             = optional(bool, false)
    landing_zone_key    = optional(string, "00")
    computer_name       = optional(string)
    resource_group_name = optional(string)
    action_group_ids    = optional(list(string), [])
    tags                = optional(map(string), {})
  })
  default = {}
}

variable "f5_subscription_id" {
  description = "The subscription ID for the F5 VPN."
  type        = string
  default     = "ed302caf-ec27-4c64-a05e-85731c3ce90e"
}
