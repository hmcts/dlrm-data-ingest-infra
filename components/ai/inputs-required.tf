variable "env" {
  type        = string
  description = "The environment to deploy resources to."
}

variable "builtFrom" {
  type        = string
  description = "The name of the repository these resources are builtFrom."
}

variable "product" {
  type        = string
  description = "The name of the prodcut this infrastructure supports."
}

variable "location" {
  type    = string
  default = "uksouth"
}

variable "project" {
  type    = string
  default = "sds"
}

variable "component" {
  type    = string
  default = "ai"
}

variable "ip_rules" {
  default = []
}

variable "cognitive_account_sku" {
  default = "F0"
}
