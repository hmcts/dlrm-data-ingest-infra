variable "resource_group_name" {
  type        = string
  description = "The name of the resource group to deploy the logic app into."
}

variable "landing_zone_key" {
  type        = string
  description = "The Key identifier for the landing zone."
}

variable "env" {
  type        = string
  description = "The environment identifier."
}

variable "common_tags" {
  type        = map(string)
  description = "Map of tags to apply to the Azure resources."
}

variable "private_endpoint_subnet_id" {
  type        = string
  description = "The ID of the subnet to deploy the private endpoint into."
}

variable "logicapp_subnet_id" {
  type        = string
  description = "The ID of the subnet to deploy the Logic App into."
}

variable "sql_server_fqdn" {
  type        = string
  description = "FQDN of the SQL Server to connect the logic app to."
}

variable "sql_database_name" {
  type        = string
  description = "Name of the SQL Database to connect the logic app to."
}
