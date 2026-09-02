variable "resource_group_name" {
  type        = string
  description = "The name of the resource group to deploy the function app into."
}

variable "landing_zone_key" {
  type        = string
  description = "The key identifier for the landing zone."
}

variable "env" {
  type        = string
  description = "The environment identifier."
}

variable "common_tags" {
  type        = map(string)
  description = "Map of tags to apply to the Azure resources."
}

variable "function_app_subnet_id" {
  type        = string
  description = "The ID of the delegated subnet to integrate the function app into (Microsoft.Web/serverFarms)."
}

variable "private_endpoint_subnet_id" {
  type        = string
  description = "The ID of the subnet to deploy the storage account private endpoint into."
}
