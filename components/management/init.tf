terraform {
  required_version = "1.10.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.117.0"
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
  alias                      = "ssptl"
  skip_provider_registration = true
  features {}
  subscription_id = local.ssptl_sub_id
}
