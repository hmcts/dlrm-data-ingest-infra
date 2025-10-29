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

#Event Hub settings

eventhub_ns_sku          = "Premium"
message_retention        = "190"
services                 = {}
eventhub_consumer_groups = {}

existing_purview_account = {
  resource_id                    = "/subscriptions/da8a21e5-d260-4162-9391-6bdadf9103f8/resourceGroups/ingest-mgmt-rg-stg/providers/Microsoft.Purview/accounts/ingest-mgmt-purview-stg"
  managed_storage_account_id     = "/subscriptions/da8a21e5-d260-4162-9391-6bdadf9103f8/resourceGroups/ingest-mgmt-purview-stg/providers/Microsoft.Storage/storageAccounts/scanuksouthjvoivnx"
  managed_event_hub_namespace_id = "/subscriptions/da8a21e5-d260-4162-9391-6bdadf9103f8/resourcegroups/ingest-mgmt-purview-stg/providers/Microsoft.EventHub/namespaces/Atlas-29d1f0ea-be32-44a6-81aa-3dc42e7b18bb"
  identity = {
    principal_id = "43a67ac7-4006-4665-95b3-517db7e679f6"
    tenant_id    = "531ff96d-0ae9-462a-8d2d-bec7c0b42082"
  }
}

landing_zones = {
  "00" = {
    project                              = "DLRM Ingestion Engine"
    use_microsoft_ip_kit_structure       = true
    deploy_bastion                       = true
    deploy_sftp_storage                  = true
    adf_deploy_purview_private_endpoints = false
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
        name  = "DTS DLRM Data Ingestion Admin (env:production)"
        type  = "Group"
        roles = ["Owner", "Storage Blob Data Owner"]
      }
    ]
    gh_runners = {
      "dlrm-ingestionengine" = {
        deploy            = true
        token_vault_id    = "/subscriptions/e9674938-57cb-43ff-a440-1917658e468c/resourceGroups/ingest-mgmt-rg-prod/providers/Microsoft.KeyVault/vaults/ingest-mgmt-kv-prod"
        token_secret_name = "dlrm-ingestionengine-token"
      }
    }
    legacy_databases = {
      legacy-sql = {
        computer_name   = "ingest00-legacy"
        public_ip       = true
        source_image_id = "/subscriptions/e9674938-57cb-43ff-a440-1917658e468c/resourceGroups/data-ingest-images-rg/providers/Microsoft.Compute/galleries/dataingest_images/images/windows-2016-sql-server-2008-R2-developer/versions/0.0.1"
        os_disk_size_gb = 1024
        size            = "Standard_D16ds_v5"
      }
    }
    additional_nsg_rules = {
      Allow-Prod-Bastion-Inbound = {
        priority                   = 220
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefixes    = ["10.11.8.37", "10.11.8.38"]
        destination_address_prefix = "*"
        description                = "Allow Prod Bastion to Data Ingest Services."
      }
      Allow-MoJ-RDP-Inbound = {
        priority                   = 250
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges    = ["3389", "1433", "1434"]
        source_address_prefixes    = ["194.33.192.0/24", "194.33.196.0/24", "194.33.248.0/24", "194.33.249.0/24", "128.77.75.64/26"]
        destination_address_prefix = "*"
        description                = "Allow RDP inbound from MoJ Ranges."
      }
    }
  }
  "05" = {
    project                        = "Crime Legacy Migration"
    deploy_bastion                 = true
    use_microsoft_ip_kit_structure = true
    role_based_access_control = [
      {
        name  = "Michael.Hayes_justice.gov.uk#EXT#@HMCTS.NET"
        type  = "User"
        roles = ["Owner", "Storage Blob Data Owner"]
      },
      {
        name  = "Andrew.McMahon4@justice.gov.uk"
        type  = "User"
        roles = ["Owner", "Storage Blob Data Owner"]
      }
    ]
    legacy_databases = {
      legacy-sql = {
        computer_name    = "ingest05-legacy"
        type             = "linux"
        publisher_name   = "oracle"
        offer            = "oracle-database"
        sku              = "oracle_db_12_2_0_1_ee"
        version          = "latest"
        os_disk_size_gb  = 512
        bootstrap_script = <<-EOF
          #!/bin/bash
          yum install -y cloud-utils-growpart
          growpart /dev/sda 2
          btrfs filesystem resize max /
        EOF
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
    }
  }
}
install_azure_monitor   = true
systemassigned_identity = true

arm_object_id = "99309157-39e2-4de2-a17b-d407db15cec2"

# AI settings
cognitive_account_sku              = "S0"
existing_cognitive_account_name    = "dlrm-ingest-cognitive-standard-prod"
compute_instance_public_ip_enabled = true
