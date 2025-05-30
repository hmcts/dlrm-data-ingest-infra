terraform {
  required_version = "1.11.1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.116.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "2.2.0"
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
  alias                           = "f5"
  resource_provider_registrations = "none"
  features {}
  subscription_id = var.f5_subscription_id
}

provider "azurerm" {
  alias                           = "ssptl"
  resource_provider_registrations = "none"
  features {}
  subscription_id = local.ssptl_sub_id
}

provider "azurerm" {
  alias                           = "cftptl"
  resource_provider_registrations = "none"
  features {}
  subscription_id = local.cftptl_sub_id
}

provider "azurerm" {
  alias                           = "soc"
  resource_provider_registrations = "none"
  features {}
  subscription_id = local.soc_sub_id
}

provider "azurerm" {
  alias                           = "cnp"
  resource_provider_registrations = "none"
  features {}
  subscription_id = local.is_prod ? local.cnp_prod_sub_id : local.cnp_nonprod_sub_id
}
provider "azurerm" {
  alias = "dcr"
  features {}
  subscription_id = var.env == "prod" || var.env == "production" ? "8999dec3-0104-4a27-94ee-6588559729d1" : var.env == "sbox" || var.env == "sandbox" ? "bf308a5c-0624-4334-8ff8-8dca9fd43783" : "1c4f0704-a29e-403d-b719-b90c34ef14c9"
}