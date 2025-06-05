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

variable "ip_rules" {
  default = []
}

variable "cognitive_account_ip_rules" {
  default = []
}

variable "ml_compute_instances" {
  description = "Number of compute instances to create"
  type        = number
  default     = 1
}