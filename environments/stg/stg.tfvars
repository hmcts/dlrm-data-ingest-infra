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

eventhub_ns_sku          = "Premium"
message_retention        = "190"
services                 = {}
eventhub_consumer_groups = {}

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
        computer_name   = "ingest00-legacy"
        public_ip       = true
        source_image_id = "/subscriptions/e9674938-57cb-43ff-a440-1917658e468c/resourceGroups/data-ingest-images-rg/providers/Microsoft.Compute/galleries/dataingest_images/images/windows-2016-sql-server-2008-R2-developer/versions/0.0.1"
        os_disk_size_gb = 1024
        size            = "Standard_D16ds_v5"
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
        name  = "DTS Crime Legacy Data Migration Admin (env:staging)"
        type  = "Group"
        roles = ["Owner", "Storage Blob Data Owner"]
      },
      {
        name  = "DTS Crime Legacy Data Migration User (env:staging)"
        type  = "Group"
        roles = ["Reader"]
      }
    ]
    legacy_databases = {
      legacy-sql = {
        computer_name    = "ingest05-legacy"
        type             = "linux"
        public_ip        = true
        publisher_name   = "oracle"
        offer            = "oracle-database"
        sku              = "oracle_db_12_2_0_1_ee"
        version          = "latest"
        os_disk_size_gb  = 512
        data_disks = [
          {
            name                 = "ingest05-legacy-data-disk-01"
            disk_size_gb         = 10240
            lun                  = 0
            caching              = "None"
            storage_account_type = "StandardSSD_LRS"
          }
        ]
        bootstrap_script = <<-EOF
          #!/bin/bash
          yum install -y cloud-utils-growpart
          growpart /dev/sda 2
          btrfs filesystem resize max /
        EOF
      }
    }

    gh_runners = {
      "dlrm-ingestionengine" = {
        deploy            = true
        token_vault_id    = "/subscriptions/da8a21e5-d260-4162-9391-6bdadf9103f8/resourceGroups/ingest-mgmt-rg-stg/providers/Microsoft.KeyVault/vaults/ingest-mgmt-kv-stg"
        token_secret_name = "dlrm-ingestionengine-token"
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
      Allow-CLDM-JBox-Inbound = {
        priority                   = 230
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "10.25.250.6/32"
        destination_address_prefix = "*"
        description                = "Allow Crime Legacy Data Migration JBox."
      }
      Allow-MoJ-RDP-Inbound = {
        priority                   = 250
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges    = ["3389", "1521"]
        source_address_prefixes    = ["194.33.192.0/24", "194.33.196.0/24", "194.33.248.0/24", "194.33.249.0/24", "128.77.75.64/26"]
        destination_address_prefix = "*"
        description                = "Allow RDP inbound from MoJ Ranges."
      }
    }
  }
}
install_azure_monitor   = true
systemassigned_identity = true
zone_redundant          = true

arm_object_id = "fd6e5281-058b-490f-8c90-186c7f057502"
