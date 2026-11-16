# The AI resources are now managed by hmcts/dlrm-aria-doc-migration-iac (infra/components/aria-doc-migration),
# which imports them in place. These blocks drop them from this component's state without destroying anything.
# Once applied in every environment, this component and its pipeline stages can be deleted.

removed {
  from = azurerm_resource_group.rg

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.ai

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.key_vault

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.application_insights

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.cognitive_account_primary_access_key

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.cognitive_account_secondary_access_key

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_cognitive_account.openai

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_role_assignment.poc_group

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_role_assignment.poc_group_sa_blob_contributor

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_role_assignment.poc_group_sa_contributor

  lifecycle {
    destroy = false
  }
}
