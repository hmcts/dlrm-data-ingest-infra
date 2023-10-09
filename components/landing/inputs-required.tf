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
  type        = string
  description = "The IP address of the next hop in the route table. Should be the Palo Alto load balancer for the given environment."
}

variable "landing_address_space" {
  description = "The address space that is used the VNet."
  type        = list(string)
}

variable "services_subnet_address_space" {
  description = "The address space for the services subnet."
  type        = list(string)
}

variable "services_mysql_subnet_address_space" {
  description = "The address space for the services MySQL subnet."
  type        = list(string)
}

variable "data_bricks_public_subnet_address_space" {
  description = "The address space for the DataBricks public subnet."
  type        = list(string)
}

variable "data_bricks_private_subnet_address_space" {
  description = "The address space for the DataBricks private subnet."
  type        = list(string)
}

variable "data_bricks_product_public_subnet_address_space" {
  description = "The address space for the DataBricks Product public subnet."
  type        = list(string)
}

variable "data_bricks_product_private_subnet_address_space" {
  description = "The address space for the DataBricks Product private subnet."
  type        = list(string)
}

variable "data_integration_001_subnet_address_space" {
  description = "The address space for the data ingration 001 subnet."
  type        = list(string)
}

variable "data_integration_002_subnet_address_space" {
  description = "The address space for the data integration 002 subnet."
  type        = list(string)
}

variable "data_product_001_subnet_address_space" {
  description = "The address space for the data product 001 subnet."
  type        = list(string)
}

variable "data_product_002_subnet_address_space" {
  description = "The address space for the data product 002 subnet."
  type        = list(string)
}

