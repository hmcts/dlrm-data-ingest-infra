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
