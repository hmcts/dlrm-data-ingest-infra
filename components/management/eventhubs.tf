# Existing eventhubs brought into IaC
resource "azurerm_eventhub" "evh_apl_ack_dev" {
  name                = "evh-apl-ack-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
  partition_count     = 1
  message_retention   = 1
  status              = "Active"

  lifecycle {
    ignore_changes = [status]
  }
}

resource "azurerm_eventhub" "evh_apl_dl_dev" {
  name                = "evh-apl-dl-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
  partition_count     = 1
  message_retention   = 1
  status              = "Active"

  lifecycle {
    ignore_changes = [status]
  }
}

resource "azurerm_eventhub" "evh_apl_pub_dev" {
  name                = "evh-apl-pub-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
  partition_count     = 18
  message_retention   = 1
  status              = "Active"

  lifecycle {
    ignore_changes = [status]
  }
}

resource "azurerm_eventhub" "evh_bl_ack_dev" {
  name                = "evh-bl-ack-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name

  partition_count   = 10
  message_retention = 1
  status            = "Active"

  lifecycle {
    ignore_changes = [status]
  }
}

resource "azurerm_eventhub" "evh-bl-dl-dev" {
  name                = "evh-bl-dl-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name

  partition_count   = 8
  message_retention = 1
  status            = "Active"

  lifecycle {
    ignore_changes = [status]
  }
}

resource "azurerm_eventhub" "evh-bl-pub-dev" {
  name                = "evh-bl-pub-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name

  partition_count   = 1
  message_retention = 1
  status            = "Active"

  lifecycle {
    ignore_changes = [status]
  }
}

resource "azurerm_eventhub" "evh-joh-dl-dev" {
  name                = "evh-joh-dl-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name

  partition_count   = 1
  message_retention = 1
  status            = "Active"

  lifecycle {
    ignore_changes = [status]
  }
}

resource "azurerm_eventhub" "evh-joh-pub-dev" {
  name                = "evh-joh-pub-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name

  partition_count   = 18
  message_retention = 1
  status            = "Active"

  lifecycle {
    ignore_changes = [status]
  }
}

resource "azurerm_eventhub" "evh-td-dl-dev" {
  name                = "evh-td-dl-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name

  partition_count   = 1
  message_retention = 1
  status            = "Active"

  lifecycle {
    ignore_changes = [status]
  }
}

resource "azurerm_eventhub" "evh-td-pub-dev" {
  name                = "evh-td-pub-dev-uks-dlrm-01"
  namespace_name      = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name

  partition_count   = 18
  message_retention = 1
  status            = "Active"

  lifecycle {
    ignore_changes = [status]
  }
}
