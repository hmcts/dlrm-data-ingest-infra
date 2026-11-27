variable "ftps_state" {
  type        = string
  description = "FTP publishing state. Accepts only Disabled or FtpsOnly. Omitted and null values use FtpsOnly."
  default     = "FtpsOnly"

  validation {
    condition     = var.ftps_state == null ? true : contains(["Disabled", "FtpsOnly"], var.ftps_state)
    error_message = "ftps_state must be exactly Disabled or FtpsOnly."
  }
}

variable "site_config" {
  type = object({
    runtime_scale_monitoring_enabled = optional(bool)
    dotnet_framework_version         = optional(string)
  })
  description = "Optional runtime settings to preserve when configuring the Logic App site."
  default     = {}
  nullable    = false
}

variable "os_type" {
  type        = string
  description = "The operating system type of the app service plan."
  default     = "Windows"
}

variable "asp_sku_name" {
  type        = string
  description = "The SKU name of the app service plan."
  default     = "WS1"
}

variable "storage_account_tier" {
  type        = string
  description = "The tier of the storage account."
  default     = "Standard"
}

variable "storage_account_kind" {
  type        = string
  description = "The kind of the storage account."
  default     = "StorageV2"
}

variable "storage_replication_type" {
  type        = string
  description = "The replication type of the storage account."
  default     = "LRS"
}
