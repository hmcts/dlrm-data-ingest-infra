terraform {
  required_version = "1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.75.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
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
  alias = "soc"
  features {}
  subscription_id = local.soc_sub_id
}

provider "azurerm" {
  alias = "cnp"
  features {}
  subscription_id = local.is_prod ? local.cnp_prod_sub_id : local.cnp_nonprod_sub_id
}
