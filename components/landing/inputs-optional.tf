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
variable "private_link_access" {
  type = list(object({
    endpoint_resource_id = string
    endpoint_tenant_id   = string
  }))
  description = "List of private_link_access"
  default     = []
}

variable "github_configuration" {
  description = "Optional GitHub configuration settings for the Azure Data Factory."
  type        = map(object({
    branch_name        = string
    git_url            = string
    repository_name    = string
    root_folder        = string
    publishing_enabled = bool
  }))
  
  default     = {}
}