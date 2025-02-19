module "data_landing_zone" {
  source = "github.com/hmcts/terraform-module-data-landing-zone?ref=main"

  for_each = var.landing_zones

  providers = {
    azurerm        = azurerm
    azurerm.hub    = azurerm.hub
    azurerm.ssptl  = azurerm.ssptl
    azurerm.cftptl = azurerm.cftptl
    azurerm.soc    = azurerm.soc
    azurerm.cnp    = azurerm.cnp
    azurerm.dcr    = azurerm.dcr
  }

  env                                              = var.env
  name                                             = "ingest${each.key}"
  existing_purview_account                         = var.existing_purview_account
  common_tags                                      = merge(module.ctags.common_tags, local.auto_shutdown_common_tags, { "Data-Ingest-Project" = each.value.project })
  default_route_next_hop_ip                        = var.default_route_next_hop_ip
  vnet_address_space                               = concat([cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2)), cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2) + 1)], each.value.additional_vnet_address_space)
  services_mysql_subnet_address_space              = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2)), 3, 1)]
  data_bricks_public_subnet_address_space          = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2)), 3, 2)]
  data_bricks_private_subnet_address_space         = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2)), 3, 3)]
  data_bricks_product_public_subnet_address_space  = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2)), 3, 4)]
  services_subnet_address_space                    = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2)), 3, 0)]
  data_bricks_product_private_subnet_address_space = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2)), 3, 5)]
  services_bastion_subnet_address_space            = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2)), 3, 6)]
  data_integration_001_subnet_address_space        = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2) + 1), 3, 0)]
  data_integration_002_subnet_address_space        = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2) + 1), 3, 1)]
  data_product_001_subnet_address_space            = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2) + 1), 2, 1)]
  data_product_002_subnet_address_space            = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2) + 1), 2, 2)]
  additional_subnets = length(each.value.gh_runners) == 0 ? {} : {
    gh-runners = {
      address_prefixes = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2) + 1), 3, 6)]
      delegations = {
        gh-runners-delegation = {
          service_name = "Microsoft.ContainerInstance/containerGroups"
          actions      = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
    }
  }
  hub_vnet_name                        = var.hub_vnet_name
  hub_resource_group_name              = var.hub_resource_group_name
  legacy_databases                     = each.value.legacy_databases
  use_microsoft_ip_kit_structure       = each.value.use_microsoft_ip_kit_structure
  adf_deploy_purview_private_endpoints = each.value.adf_deploy_purview_private_endpoints
  additional_nsg_rules                 = each.value.additional_nsg_rules
  key_vault_readers                    = ["145da22b-a3cb-4ba8-b735-22c94b5eea6c"]


  install_azure_monitor   = var.install_azure_monitor
  systemassigned_identity = var.systemassigned_identity
  install_azure_bastion   = var.install_azure_bastion
}

# Define the Azure Bastion subnet
resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.hub_resource_group_name
  virtual_network_name = module.data_landing_zone.hub_vnet_name
  address_prefixes     = ["10.0.1.0/27"]
}

# Define the Azure Bastion resource
resource "azurerm_bastion_host" "example" {
  name                = "example-bastion"
  location            = "uksouth"
  resource_group_name = var.hub_resource_group_name

  dns_name = "example-bastion"
  sku      = "Basic"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

# Define the public IP for Azure Bastion
resource "azurerm_public_ip" "example" {
  name                = "example-bastion-pip"
  location            = "uksouth"
  resource_group_name = var.hub_resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}
