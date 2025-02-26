resource "azurerm_eventhub_namespace_authorization_rule" "dlrm_eventhub_namespace_sender" {
  name                = "dlrm-eventhub-namespace-sender"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
  listen              = false
  send                = true
  manage              = false

}

resource "azurerm_eventhub_namespace_authorization_rule" "root_manage_shared_access_key" {
  name                = "RootManageSharedAccessKey"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
  listen              = true
  send                = true
  manage              = true

}

resource "azurerm_eventhub_authorization_rule" "evh_joh_pub_dev_adls_account_key" {
  name                = "ADLSAccountKey"
  eventhub_name       = "evh-joh-pub-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name

  listen = true
  send   = true
  manage = true

}

resource "azurerm_eventhub_authorization_rule" "evh_bl_pub_dev_uks_dlrm_01_aria_bails" {
  name                = "aria-bails"
  eventhub_name       = "evh-bl-pub-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name

  listen = true
  send   = true
  manage = true

}

resource "azurerm_eventhub_authorization_rule" "evh_bl_ack_dev_uks_dlrm_01_ariabailsack" {
  name                = "ariabailsack"
  eventhub_name       = "evh-bl-ack-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name

  listen = true
  send   = true
  manage = true

}

resource "azurerm_eventhub_authorization_rule" "evh_bl_dl_dev_uks_dlrm_01_evh_bl_dl_dev_uks_dlrm_01" {
  name                = "evh-bl-dl-dev-uks-dlrm-01"
  eventhub_name       = "evh-bl-dl-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name

  listen = true
  send   = true
  manage = true

}

resource "azurerm_eventhub_authorization_rule" "evh_joh_dl_dev_uks_dlrm_01_joh_deadletterque" {
  name                = "JOH-deadletterque"
  eventhub_name       = "evh-joh-dl-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name

  listen = true
  send   = false
  manage = false

}

resource "azurerm_eventhub_authorization_rule" "evh_apl_dl_dev_uks_dlrm_01_manager" {
  name                = "manager"
  eventhub_name       = "evh-apl-dl-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name

  manage = true
  listen = true
  send   = true

}

resource "azurerm_eventhub_authorization_rule" "evh_td_dl_dev_uks_dlrm_01_test_dl" {
  name                = "test-dl"
  eventhub_name       = "evh-td-dl-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name

  manage = true
  listen = true
  send   = true

}

resource "azurerm_eventhub_authorization_rule" "evh_td_pub_dev_uks_dlrm_01_test_nsa" {
  name                = "test-nsa"
  eventhub_name       = "evh-td-pub-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name

  manage = true
  listen = true
  send   = true

}
