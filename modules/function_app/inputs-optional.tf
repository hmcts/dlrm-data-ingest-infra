variable "ftps_state" {
  type        = string
  description = "FTP publishing state. Accepts only Disabled or FtpsOnly. Omitted and null values disable FTP publishing."
  default     = "Disabled"

  validation {
    condition     = var.ftps_state == null ? true : contains(["Disabled", "FtpsOnly"], var.ftps_state)
    error_message = "ftps_state must be exactly Disabled or FtpsOnly."
  }
}

variable "location" {
  type        = string
  description = "The Azure region to deploy the function app into."
  default     = "uksouth"
}

variable "service_plan_sku" {
  type        = string
  description = "The SKU of the app service plan. Elastic Premium (EP1+) is required for regional VNet integration."
  default     = "EP1"
}

variable "python_version" {
  type        = string
  description = "The Python runtime version for the Linux function app."
  default     = "3.12"
}

variable "storage_account_tier" {
  type        = string
  description = "The tier of the backing storage account."
  default     = "Standard"
}

variable "storage_account_kind" {
  type        = string
  description = "The kind of the backing storage account."
  default     = "StorageV2"
}

variable "storage_replication_type" {
  type        = string
  description = "The replication type of the backing storage account."
  default     = "LRS"
}
