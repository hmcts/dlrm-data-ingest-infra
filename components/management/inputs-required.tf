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

variable "default_route_next_hop_ip" {
  description = "IP address of the next hop for the default route, this will usually be the private ip of the Palo Load Balancer."
  type        = string
}

variable "mgmt_address_space" {
  description = "The address space covered by the virtual network."
  type        = list(string)
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

variable "eventhub_ns_sku" {}
variable "services" {}
variable "message_retention" {}

