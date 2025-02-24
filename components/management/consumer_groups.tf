resource "azurerm_eventhub_consumer_group" "evh_apl_ack_dev" {
  name                = "evh-apl-ack-dev-uks-dlrm-01/$Default"
  eventhub_name       = "evh-apl-ack-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_eventhub_consumer_group" "evh_apl_dl_dev" {
  name                = "evh-apl-dl-dev-uks-dlrm-01/$Default"
  eventhub_name       = "evh-apl-dl-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_eventhub_consumer_group" "evh_apl_pub_dev" {
  name                = "evh-apl-pub-dev-uks-dlrm-01/$Default"
  eventhub_name       = "evh-apl-pub-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_eventhub_consumer_group" "evh_bl_ack_dev" {
  name                = "evh-bl-ack-dev-uks-dlrm-01/$Default"
  eventhub_name       = "evh-bl-ack-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_eventhub_consumer_group" "evh_bl_dl_dev" {
  name                = "evh-bl-dl-dev-uks-dlrm-01/$Default"
  eventhub_name       = "evh-bl-dl-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_eventhub_consumer_group" "evh_bl_pub_dev" {
  name                = "evh-bl-pub-dev-uks-dlrm-01/$Default"
  eventhub_name       = "evh-bl-pub-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_eventhub_consumer_group" "evh_joh_dl_dev" {
  name                = "evh-joh-dl-dev-uks-dlrm-01/$Default"
  eventhub_name       = "evh-joh-dl-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_eventhub_consumer_group" "evh_joh_pub_dev" {
  name                = "evh-joh-pub-dev-uks-dlrm-01/$Default"
  eventhub_name       = "evh-joh-pub-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_eventhub_consumer_group" "evh_td_dl_dev" {
  name                = "evh-td-dl-dev-uks-dlrm-01/$Default"
  eventhub_name       = "evh-td-dl-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_eventhub_consumer_group" "evh_td_pub_dev" {
  name                = "evh-td-pub-dev-uks-dlrm-01/$Default"
  eventhub_name       = "evh-td-pub-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_eventhub_consumer_group" "evh_apl_pub_dev_preview" {
  name                = "evh-apl-pub-dev-uks-dlrm-01/preview_data_consumer_group"
  eventhub_name       = "evh-apl-pub-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_eventhub_consumer_group" "evh_joh_pub_dev_preview" {
  name                = "evh-joh-pub-dev-uks-dlrm-01/preview_data_consumer_group"
  eventhub_name       = "evh-joh-pub-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_eventhub_consumer_group" "evh_td_pub_dev_preview" {
  name                = "evh-td-pub-dev-uks-dlrm-01/preview_data_consumer_group"
  eventhub_name       = "evh-td-pub-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_eventhub_consumer_group" "evh_apl_dl_dev_test" {
  name                = "evh-apl-dl-dev-uks-dlrm-01/test"
  eventhub_name       = "evh-apl-dl-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_eventhub_consumer_group" "evh_td_dl_dev_test" {
  name                = "evh-td-dl-dev-uks-dlrm-01/test"
  eventhub_name       = "evh-td-dl-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
}
