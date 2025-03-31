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

variable "min_node_count" {
  description = "Minimum number of nodes in the compute cluster"
  type        = number
  default     = 0
}