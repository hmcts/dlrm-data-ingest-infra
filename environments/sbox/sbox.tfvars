default_route_next_hop_ip = "10.10.200.36"
hub_vnet_name             = "hmcts-hub-sbox-int"
hub_resource_group_name   = "hmcts-hub-sbox-int"
hub_subscription_id       = "ea3a8c1e-af9d-4108-bc86-a7e2d267f49c"
mgmt_address_space        = ["10.247.2.0/24"]

mgmt_additional_kv_access_policies = {
  "71523201-c046-4371-bdd0-a1e1abcd05c5" = {
    secret_permissions = ["Get", "List"]
  }
}

#Event Hub settings

eventhub_ns_sku   = "Standard"
message_retention = "7"
services          = []
eventhub_capacity = 25

landing_zones = {
  "00" = {
    project                        = "DLRM Ingestion Engine"
    use_microsoft_ip_kit_structure = true
    role_based_access_control = [
      {
        name = "prasanna.krishnan@justice.gov.uk"
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
        name  = "DTS DLRM Data Ingestion Admin (env:sandbox)"
        type  = "Group"
        roles = ["Owner", "Storage Blob Data Owner"]
      }
    ]
    gh_runners = {
      "dlrm-ingestionengine" = {
        deploy            = true
        token_vault_id    = "/subscriptions/df72bb30-d6fb-47bd-82ee-5eb87473ddb3/resourceGroups/ingest-mgmt-rg-sbox/providers/Microsoft.KeyVault/vaults/ingest-mgmt-kv-sbox"
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
  "01" = {
    project                        = "DLRM Ingestion Engine"
    use_microsoft_ip_kit_structure = true
    role_based_access_control = [
      {
        name = "prasanna.krishnan@justice.gov.uk"
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
        name  = "DTS DLRM Data Ingestion Admin (env:sandbox)"
        type  = "Group"
        roles = ["Owner", "Storage Blob Data Owner"]
      }
    ]
    gh_runners = {
      "dlrm-ingestionengine" = {
        deploy            = true
        token_vault_id    = "/subscriptions/df72bb30-d6fb-47bd-82ee-5eb87473ddb3/resourceGroups/ingest-mgmt-rg-sbox/providers/Microsoft.KeyVault/vaults/ingest-mgmt-kv-sbox"
        token_secret_name = "dlrm-ingestionengine-token"
      }
    }
    legacy_databases = {
      legacy-sql = {
        computer_name  = "ingest01-legacy"
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
