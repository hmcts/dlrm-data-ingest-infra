mock_provider "azurerm" {
  mock_resource "azurerm_service_plan" {
    defaults = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/ftp-test/providers/Microsoft.Web/serverfarms/ftp-test"
    }
  }

  mock_resource "azurerm_storage_account" {
    defaults = {
      id                 = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/ftp-test/providers/Microsoft.Storage/storageAccounts/ftptest"
      primary_access_key = "bW9jay1zdG9yYWdlLWtleQ=="
    }
  }
}

mock_provider "azurerm" {
  alias = "ssptl"

  mock_data "azurerm_subnet" {
    defaults = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/ftp-test/providers/Microsoft.Network/virtualNetworks/ftp-test/subnets/ssptl"
    }
  }
}

mock_provider "azurerm" {
  alias = "cftptl"

  mock_data "azurerm_private_dns_zone" {
    defaults = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/ftp-test/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
    }
  }
}

mock_provider "azapi" {}

override_module {
  target = module.application_insights
  outputs = {
    instrumentation_key = "00000000-0000-0000-0000-000000000000"
    connection_string   = "InstrumentationKey=00000000-0000-0000-0000-000000000000"
  }
}

variables {
  resource_group_name        = "ftp-test"
  landing_zone_key           = "test"
  env                        = "sbox"
  common_tags                = {}
  private_endpoint_subnet_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/ftp-test/providers/Microsoft.Network/virtualNetworks/ftp-test/subnets/private-endpoints"
  logicapp_subnet_id         = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/ftp-test/providers/Microsoft.Network/virtualNetworks/ftp-test/subnets/logic-app"
  sql_server_fqdn            = "ftp-test.database.windows.net"
  sql_database_name          = "ftp-test"
}

run "caller_provider_version" {
  command = plan

  module {
    source = "./tests/fixtures/providers"
  }
}

run "omitted_disables_ftp" {
  command = plan

  assert {
    condition     = azurerm_logic_app_standard.this.site_config[0].ftps_state == "Disabled"
    error_message = "Omitting ftps_state must disable FTP on the Logic App resource."
  }
}

run "explicit_disabled_reaches_resource" {
  command = plan

  variables {
    ftps_state = "Disabled"
  }

  assert {
    condition     = azurerm_logic_app_standard.this.site_config[0].ftps_state == "Disabled"
    error_message = "Disabled must reach the Logic App resource."
  }
}

run "ftps_only_reaches_resource" {
  command = plan

  variables {
    ftps_state = "FtpsOnly"
  }

  assert {
    condition     = azurerm_logic_app_standard.this.site_config[0].ftps_state == "FtpsOnly"
    error_message = "FtpsOnly must reach the Logic App resource."
  }
}

run "null_disables_ftp" {
  command = plan

  variables {
    ftps_state = null
  }

  assert {
    condition     = azurerm_logic_app_standard.this.site_config[0].ftps_state == "Disabled"
    error_message = "Explicit null must disable FTP on the Logic App resource."
  }
}

run "reject_all_allowed" {
  command = plan

  variables {
    ftps_state = "AllAllowed"
  }

  expect_failures = [var.ftps_state]
}

run "reject_empty" {
  command = plan

  variables {
    ftps_state = ""
  }

  expect_failures = [var.ftps_state]
}

run "reject_whitespace" {
  command = plan

  variables {
    ftps_state = " "
  }

  expect_failures = [var.ftps_state]
}

run "reject_wrong_case_disabled" {
  command = plan

  variables {
    ftps_state = "disabled"
  }

  expect_failures = [var.ftps_state]
}

run "reject_wrong_case_ftps_only" {
  command = plan

  variables {
    ftps_state = "ftpsonly"
  }

  expect_failures = [var.ftps_state]
}

run "reject_padded_value" {
  command = plan

  variables {
    ftps_state = " FtpsOnly "
  }

  expect_failures = [var.ftps_state]
}

run "reject_unsupported_value" {
  command = plan

  variables {
    ftps_state = "Enabled"
  }

  expect_failures = [var.ftps_state]
}