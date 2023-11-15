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

variable "rbac_principals" {
  type = list(object({
    name = optional(string)
    type = optional(string, "user")
    mail = optional(string)
  }))
  description = "Map of RBAC principals to create role assignments for. These can be users, groups or service principals."

  validation {
    condition = alltrue([
      contains(["user", "group", "service principal"], lower(var.rbac_principals.type)),
      anytrue([
        var.rbac_principals.name != null,
        var.rbac_principals.mail != null
      ])
    ])
    error_message = "The type must be either 'user', 'group' or 'service principal' and either mail or name must be specified."
  }
  default = []
}
