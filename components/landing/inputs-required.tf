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
    })), [])
    project = string
    gh_runners = optional(map(object({
      deploy            = optional(bool, true)
      token_vault_id    = string
      token_secret_name = string
    })), {})
    legacy_databases = optional(map(object({
      size           = optional(string, "Standard_D4ds_v5")
      type           = optional(string, "windows")
      publisher_name = string
      offer          = string
      sku            = string
      version        = string
    })), {})
  }))
}

variable "default_route_next_hop_ip" {
  type        = string
  description = "The IP address of the next hop in the route table. Should be the Palo Alto load balancer for the given environment."
}

variable "hub_vnet_name" {
  description = "The name of the HUB virtual network."
  type        = string
}

variable "hub_resource_group_name" {
  description = "The name of the resource group containing the HUB virtual network."
  type        = string
}

variable "hub_subscription_id" {
  description = "The ID of the subscription containing the HUB virtual network."
  type        = string
}
