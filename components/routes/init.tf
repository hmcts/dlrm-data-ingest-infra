terraform {
  required_version = "1.14.1"

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

provider "azurerm" {
  alias                           = "aat"
  resource_provider_registrations = "none"
  features {}
  subscription_id = var.aat_subscription_id
}
