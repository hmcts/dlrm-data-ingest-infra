terraform {
  required_version = "1.10.1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.116.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  subscription_id = local.ssptl_sub_id
  features {}
}
