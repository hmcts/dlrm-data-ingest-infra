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
    address_space                                    = list(string)
    services_subnet_address_space                    = list(string)
    services_mysql_subnet_address_space              = list(string)
    data_bricks_public_subnet_address_space          = list(string)
    data_bricks_private_subnet_address_space         = list(string)
    data_bricks_product_public_subnet_address_space  = list(string)
    data_bricks_product_private_subnet_address_space = list(string)
    data_integration_001_subnet_address_space        = list(string)
    data_integration_002_subnet_address_space        = list(string)
    data_product_001_subnet_address_space            = list(string)
    data_product_002_subnet_address_space            = list(string)
    role_based_access_control = optional(list(object({
      name = optional(string)
      type = optional(string, "user")
      mail = optional(string),
      role = optional(string, "Owner")
    })))
    project = string
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
