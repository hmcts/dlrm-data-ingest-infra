terraform {
  required_version = "1.9.6"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.116.0"
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
provider "azurerm" {
  alias = "dcr"
  features {}
  subscription_id = var.env == "prod" || var.env == "production" ? "8999dec3-0104-4a27-94ee-6588559729d1" : var.env == "sbox" || var.env == "sandbox" ? "bf308a5c-0624-4334-8ff8-8dca9fd43783" : "1c4f0704-a29e-403d-b719-b90c34ef14c9"
}
