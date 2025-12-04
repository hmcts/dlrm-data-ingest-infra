terraform {
  required_version = "1.13.2"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.55.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  features {}
  alias           = "hub"
  subscription_id = var.hub_subscription_id
}

provider "azurerm" {
  alias                           = "ssptl"
  resource_provider_registrations = "none"
  features {}
  subscription_id = local.ssptl_sub_id
}
