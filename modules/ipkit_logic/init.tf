terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = ">= 3.7.0"
      configuration_aliases = [azurerm.ssptl, azurerm.cftptl]
    }
    azapi = {
      source  = "Azure/azapi"
      version = "1.13.1"
    }
  }
}
