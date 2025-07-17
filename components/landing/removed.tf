removed {
  from = module.data_landing_zone["00"].azurerm_storage_data_lake_gen2_filesystem.this["xcutting"]
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.data_landing_zone["01"].azurerm_storage_data_lake_gen2_filesystem.this["xcutting"]
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.data_landing_zone["02"].azurerm_storage_data_lake_gen2_filesystem.this["xcutting"]
  lifecycle {
    destroy = false
  }
}
