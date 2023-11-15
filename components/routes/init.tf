terraform {
  required_version = "1.6.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.78.0"
    }
  }

  #backend "azurerm" {}
}

provider "azurerm" {
  subscription_id = local.ssptl_sub_id
  features {}
}
