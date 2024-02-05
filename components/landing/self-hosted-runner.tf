data "azurerm_key_vault_secret" "token" {
  for_each     = { for runner in local.flattened_runners : "${runner.lz_key}${runner.gh_runner_key}" => runner }
  key_vault_id = each.value.token_vault_id
  name         = each.value.token_secret_name
}

resource "azurerm_container_group" "runner" {
  for_each            = { for runner in local.flattened_runners : "${runner.lz_key}${runner.gh_runner_key}" => runner }
  name                = "ingest${each.value.lz_key}-runner-${var.env}"
  location            = "uksouth"
  resource_group_name = "ingest${each.value.lz_key}-management-${var.env}"
  os_type             = "Linux"
  ip_address_type     = "Private"
  subnet_ids          = [module.data_landing_zone[each.value.lz_key].subnet_ids["vnet-services"]]
  container {
    name   = "runner"
    image  = "hmctspublic.azurecr.io/github-runner:prod-84d74135-1707147900"
    cpu    = "0.5"
    memory = "1.5"
    environment_variables = {
      GH_OWNER      = "hmcts"
      GH_REPOSITORY = each.value.gh_runner_key
      GH_TOKEN      = data.azurerm_key_vault_secret.token[each.key].value
    }
  }

  tags = merge(module.ctags.common_tags, { "Data-Ingest-Project" = each.value.project })
}
