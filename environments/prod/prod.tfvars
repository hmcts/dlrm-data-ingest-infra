default_route_next_hop_ip = "10.11.8.36"
hub_vnet_name             = "hmcts-hub-prod-int"
hub_resource_group_name   = "hmcts-hub-prod-int"
hub_subscription_id       = "0978315c-75fe-4ada-9d11-1eb5e0e0b214"
mgmt_address_space        = ["10.247.0.0/24"]

mgmt_additional_kv_access_policies = {
  "cf408942-3215-4a3a-bdf2-e703c688bc13" = {
    secret_permissions = ["Get", "List"]
  }
}

existing_purview_account = {
  resource_id                    = "/subscriptions/da8a21e5-d260-4162-9391-6bdadf9103f8/resourceGroups/ingest-mgmt-rg-stg/providers/Microsoft.Purview/accounts/ingest-mgmt-purview-stg"
  managed_storage_account_id     = "/subscriptions/da8a21e5-d260-4162-9391-6bdadf9103f8/resourceGroups/ingest-mgmt-purview-stg/providers/Microsoft.Storage/storageAccounts/scanuksouthjvoivnx"
  managed_event_hub_namespace_id = "/subscriptions/da8a21e5-d260-4162-9391-6bdadf9103f8/resourcegroups/ingest-mgmt-purview-stg/providers/Microsoft.EventHub/namespaces/Atlas-29d1f0ea-be32-44a6-81aa-3dc42e7b18bb"
  identity = {
    principal_id = "43a67ac7-4006-4665-95b3-517db7e679f6"
    tenant_id    = "531ff96d-0ae9-462a-8d2d-bec7c0b42082"
  }
}

landing_zones = {}
