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
