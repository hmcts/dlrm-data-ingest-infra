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

variable "landing_zones" {
  description = "The landing zones to deploy."
  type = map(object({
    role_based_access_control = optional(list(object({
      name = optional(string)
      type = optional(string, "user")
      mail = optional(string),
      role = optional(string, "Owner")
    })))
    project = string
  }))
}

variable "mgmt_address_space" {
  description = "The address space covered by the virtual network."
  type        = list(string)
}

variable "default_route_next_hop_ip" {
  type        = string
  description = "The IP address of the next hop in the route table. Should be the Palo Alto load balancer for the given environment."
}

variable "aat_subscription_id" {
  type        = string
  description = "The subscription ID for the CFT AAT environment."
  default     = "96c274ce-846d-4e48-89a7-d528432298a7"
}
