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
eventhub_ns_sku = "Premium"
services = {
  "evh-apl-ack-dev-uks-dlrm-01" = {
    partition_count   = 1
    message_retention = "1"
  }
  "evh-apl-dl-dev-uks-dlrm-01" = {
    partition_count   = 1
    message_retention = "1"
  }
  "evh-apl-pub-dev-uks-dlrm-01" = {
    partition_count   = 18
    message_retention = "1"
  }
  "evh-bl-ack-dev-uks-dlrm-01" = {
    partition_count   = 10
    message_retention = "1"
  }
  "evh-bl-dl-dev-uks-dlrm-01" = {
    partition_count   = 8
    message_retention = "1"
  }
  "evh-bl-pub-dev-uks-dlrm-01" = {
    partition_count   = 1
    message_retention = "1"
  }
  "evh-joh-dl-dev-uks-dlrm-01" = {
    partition_count   = 1
    message_retention = "1"
  }
  "evh-joh-pub-dev-uks-dlrm-01" = {
    partition_count   = 18
    message_retention = "1"
  }
  "evh-td-dl-dev-uks-dlrm-01" = {
    partition_count   = 1
    message_retention = "1"
  }
  "evh-td-pub-dev-uks-dlrm-01" = {
    partition_count   = 18
    message_retention = "1"
  }
}
eventhub_capacity    = 16
auto_inflate_enabled = false

eventhub_auth_rules = {
  "evh-apl-dl-dev-uks-dlrm-01"  = { name = "manager", listen = true, send = true, manage = true }
  "evh-bl-ack-dev-uks-dlrm-01"  = { name = "ariabailsack", listen = true, send = true, manage = true }
  "evh-bl-dl-dev-uks-dlrm-01"   = { name = "evh-bl-dl-dev-uks-dlrm-01", listen = true, send = true, manage = true }
  "evh-bl-pub-dev-uks-dlrm-01"  = { name = "aria-bails", listen = true, send = true, manage = true }
  "evh-joh-dl-dev-uks-dlrm-01"  = { name = "JOH-deadletterque", listen = true, send = false, manage = false }
  "evh-joh-pub-dev-uks-dlrm-01" = { name = "ADLSAccountKey", listen = true, send = true, manage = true }
  "evh-td-dl-dev-uks-dlrm-01"   = { name = "test-dl", listen = true, send = true, manage = true }
  "evh-td-pub-dev-uks-dlrm-01"  = { name = "test-nsa", listen = true, send = true, manage = true }
}

eventhub_consumer_groups = {
  "evh-apl-pub-dev-uks-dlrm-01" = { name = "preview_data_consumer_group" }
  "evh-joh-pub-dev-uks-dlrm-01" = { name = "preview_data_consumer_group" }
  "evh-td-pub-dev-uks-dlrm-01"  = { name = "preview_data_consumer_group" }
  "evh-apl-dl-dev-uks-dlrm-01"  = { name = "test" }
  "evh-td-dl-dev-uks-dlrm-01"   = { name = "test" }
}

landing_zones = {
  "00" = {
    project                        = "DLRM Ingestion Engine"
    deploy_bastion                 = true
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
    deploy_bastion                 = true
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
  "09" = {
    project = "AJB Test Zone"
    role_based_access_control = [
      {
        name = "alex.bance@justice.gov.uk"
        type = "User"
      },
    ]
  }
}
install_azure_monitor   = true
systemassigned_identity = true
