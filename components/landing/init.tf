terraform {
  required_version = "1.8.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.105.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "1.13.1"
    }
  }

  backend "azurerm" {}
}

provider "azapi" {}

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

provider "azurerm" {
  alias                      = "cftptl"
  skip_provider_registration = true
  features {}
  subscription_id = local.cftptl_sub_id
}

provider "azurerm" {
  alias                      = "soc"
  skip_provider_registration = true
  features {}
  subscription_id = local.soc_sub_id
}

provider "azurerm" {
  alias                      = "cnp"
  skip_provider_registration = true
  features {}
  subscription_id = local.is_prod ? local.cnp_prod_sub_id : local.cnp_nonprod_sub_id
}
