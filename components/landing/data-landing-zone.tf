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
  }

  env                                              = var.env
  name                                             = "ingest${each.key}"
  existing_purview_account                         = var.existing_purview_account
  common_tags                                      = merge(module.ctags.common_tags, { "Data-Ingest-Project" = each.value.project })
  default_route_next_hop_ip                        = var.default_route_next_hop_ip
  vnet_address_space                               = [cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2)), cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2) + 1)]
  services_mysql_subnet_address_space              = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2)), 3, 1)]
  data_bricks_public_subnet_address_space          = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2)), 3, 2)]
  data_bricks_private_subnet_address_space         = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2)), 3, 3)]
  data_bricks_product_public_subnet_address_space  = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2)), 3, 4)]
  services_subnet_address_space                    = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2)), 3, 0)]
  data_bricks_product_private_subnet_address_space = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2)), 3, 5)]
  data_integration_001_subnet_address_space        = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2) + 1), 3, 0)]
  data_integration_002_subnet_address_space        = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2) + 1), 3, 1)]
  data_product_001_subnet_address_space            = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2) + 1), 2, 1)]
  data_product_002_subnet_address_space            = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2) + 1), 2, 2)]
  additional_subnets = each.value.gh_runners == {} ? {} : {
    gh-runners = {
      address_prefixes = [cidrsubnet(cidrsubnet(local.data_ingest_address_space, 6, local.subnet_starting_index[var.env] + (parseint(each.key, 10) * 2) + 1), 3, 3)]
      delegations = {
        gh-runners-delegation = {
          service_name = "Microsoft.ContainerInstance/containerGroups"
          actions      = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        }
      }
    }
  }
  hub_vnet_name           = var.hub_vnet_name
  hub_resource_group_name = var.hub_resource_group_name
}
