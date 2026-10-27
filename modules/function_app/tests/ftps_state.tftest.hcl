mock_provider "azurerm" {
  mock_resource "azurerm_service_plan" {
    defaults = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/ftp-test/providers/Microsoft.Web/serverFarms/ftp-test"
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
  function_app_subnet_id     = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/ftp-test/providers/Microsoft.Network/virtualNetworks/ftp-test/subnets/function-app"
  private_endpoint_subnet_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/ftp-test/providers/Microsoft.Network/virtualNetworks/ftp-test/subnets/private-endpoints"
}

run "landing_creation_filter" {
  command = plan
  module {
    source = "./tests/fixtures/landing_filter"
  }
  variables {
    landing_zones = {
      enabled  = { deploy_function_app = true }
      disabled = { deploy_function_app = false }
    }
  }
  assert {
    condition     = output.selected_landing_zones == toset(["enabled"]) && output.caller_filter_matches
    error_message = "The unchanged landing filter must select only enabled Function Apps."
  }
}

run "omitted_disables_ftp" {
  command = plan
  assert {
    condition     = azurerm_linux_function_app.this.site_config[0].ftps_state == "Disabled"
    error_message = "Omitted ftps_state must disable FTP on the Function App."
  }
}

run "explicit_disabled_reaches_resource" {
  command = plan
  variables {
    ftps_state = "Disabled"
  }
  assert {
    condition     = azurerm_linux_function_app.this.site_config[0].ftps_state == "Disabled"
    error_message = "Disabled must reach the Function App resource."
  }
}

run "ftps_only_reaches_resource" {
  command = plan
  variables {
    ftps_state = "FtpsOnly"
  }
  assert {
    condition = (
      azurerm_linux_function_app.this.site_config[0].ftps_state == "FtpsOnly" &&
      azurerm_linux_function_app.this.site_config[0].application_stack[0].python_version == "3.12" &&
      azurerm_linux_function_app.this.site_config[0].vnet_route_all_enabled &&
      azurerm_linux_function_app.this.https_only &&
      azurerm_linux_function_app.this.identity[0].type == "SystemAssigned"
    )
    error_message = "FtpsOnly must reach the app without changing runtime, routing, HTTPS or identity."
  }
}

run "null_disables_ftp" {
  command = plan
  variables {
    ftps_state = null
  }
  assert {
    condition     = azurerm_linux_function_app.this.site_config[0].ftps_state == "Disabled"
    error_message = "Null must disable FTP on the Function App."
  }
}

run "reject_all_allowed" {
  command = plan
  variables {
    ftps_state = "AllAllowed"
  }
  expect_failures = [var.ftps_state]
}

run "reject_empty_ftp" {
  command = plan
  variables {
    ftps_state = ""
  }
  expect_failures = [var.ftps_state]
}

run "reject_whitespace_ftp" {
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

run "reject_padded_ftp" {
  command = plan
  variables {
    ftps_state = " FtpsOnly "
  }
  expect_failures = [var.ftps_state]
}

run "reject_unsupported_ftp" {
  command = plan
  variables {
    ftps_state = "Enabled"
  }
  expect_failures = [var.ftps_state]
}