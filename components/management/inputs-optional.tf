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


variable "mgmt_additional_kv_access_policies" {
  description = "Additional access policies to add to the management zone key vault"
  type = map(object({
    secret_permissions      = optional(list(string), [])
    certificate_permissions = optional(list(string), [])
    key_permissions         = optional(list(string), [])
  }))
  default = {}
}
variable "zone_redundant" {
  type        = bool
  default     = false
  description = "Allows you to make eventhub namespace zone reduntdant"
}

variable "eventhub_capacity" {
  type        = number
  default     = 1
  description = "The capacity of the eventhub namespace."
}

variable "auto_inflate_enabled" {
  type        = bool
  default     = false
  description = "Allows you to enable auto inflate in eventhub namespace."
}

variable "maximum_throughput_units" {
  type        = number
  default     = 1
  description = "Max number of throughput units in eventhub namespace."
}

variable "eventhub_auth_rules" {
  description = "Allows custom authorisation rules to be created for eventhubs"
  type = map(object({
    name   = string
    listen = bool
    send   = bool
    manage = bool
  }))
  default = {}
}

variable "eventhub_namespace_auth_rules" {
  description = "Allows custom authorisation rules to be created for eventhub namespaces"
  type = map(object({
    name   = string
    listen = bool
    send   = bool
    manage = bool
  }))
  default = {}
}

variable "eventhub_consumer_groups" {
  description = "Allows custom authorisation rules to be created for eventhub namespaces"
  type = map(object({
    name = string
  }))
}
