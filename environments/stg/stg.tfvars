default_route_next_hop_ip = "10.11.72.36"
hub_vnet_name             = "hmcts-hub-nonprodi"
hub_resource_group_name   = "hmcts-hub-nonprodi"
hub_subscription_id       = "fb084706-583f-4c9a-bdab-949aac66ba5c"
mgmt_address_space        = ["10.247.1.0/24"]

mgmt_additional_kv_access_policies = {
  "085f0992-85b4-49ae-aae8-ef47953e96f2" = {
    secret_permissions = ["Get", "List"]
  }
}

#Event Hub settings
eventhub_namespace_name = "stg-dlrm-eventhub-ns"
resource_group_name     = "ingest-mgmt-rg-stg"
eventhub_ns_sku         = "Premium"
message_retention       = "190"
services                = []

landing_zones = {
  "00" = {
    project                              = "DLRM Ingestion Engine"
    use_microsoft_ip_kit_structure       = true
    adf_deploy_purview_private_endpoints = false
    role_based_access_control = [
      {
        name = "prasanna.krishnan@justice.gov.uk"
        type = "User"
      },
      {
        name = "Matt.Lorentzen@HMCTS.NET"
        type = "User"
      },
      {
        name = "dominic.leary@justice.gov.uk"
        type = "User"
      },
      {
        name  = "qiang.zhou@hmcts.net"
        type  = "User"
        roles = ["Owner", "Storage Blob Data Owner"]
      },
      {
        name  = "DTS DLRM Data Ingestion Admin (env:staging)"
        type  = "Group"
        roles = ["Owner", "Storage Blob Data Owner"]
      }
    ]
    gh_runners = {
      "dlrm-ingestionengine" = {
        deploy            = true
        token_vault_id    = "/subscriptions/da8a21e5-d260-4162-9391-6bdadf9103f8/resourceGroups/ingest-mgmt-rg-stg/providers/Microsoft.KeyVault/vaults/ingest-mgmt-kv-stg"
        token_secret_name = "dlrm-ingestionengine-token"
      }
    }
    legacy_databases = {
      legacy-sql = {
        computer_name  = "ingest00-legacy"
        public_ip      = true
        publisher_name = "MicrosoftWindowsServer"
        offer          = "WindowsServer"
        sku            = "2016-datacenter-gensecond"
        version        = "14393.6709.240206"
      }
    }
    additional_nsg_rules = {
      Allow-F5-VPN-Inbound = {
        priority                   = 220
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "10.99.72.0/21"
        destination_address_prefix = "*"
        description                = "Allow F5 VPN."
      }
      Allow-MoJ-RDP-Inbound = {
        priority                   = 250
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges    = ["3389", "1433", "1434"]
        source_address_prefixes    = ["194.33.192.0/24", "194.33.196.0/24", "194.33.248.0/24", "194.33.249.0/24"]
        destination_address_prefix = "*"
        description                = "Allow RDP inbound from MoJ Ranges."
      }
    }
  }
}
install_azure_monitor   = true
systemassigned_identity = true
zone_redundant          = true
