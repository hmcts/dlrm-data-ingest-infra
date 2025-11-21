default_route_next_hop_ip = "10.11.72.36"
hub_vnet_name             = "hmcts-hub-nonprodi"
hub_resource_group_name   = "hmcts-hub-nonprodi"
hub_subscription_id       = "fb084706-583f-4c9a-bdab-949aac66ba5c"
mgmt_address_space        = ["10.247.2.0/24"]

mgmt_additional_kv_access_policies = {
  "71523201-c046-4371-bdd0-a1e1abcd05c5" = {
    secret_permissions = ["Get", "List"]
  }
}

# AI Services settings
min_node_count        = 1
cognitive_account_sku = "S0"
cognitive_account_ip_rules = [
  "20.3.165.95" # Document Intelligence Studio
]

# Storage account settings
ip_rules = [
  "51.11.24.49",       # Azure ML Workspace UK South IP
  "51.104.8.64/27",    # Azure ML Workspace UK South IP
  "51.104.24.96/28",   # Azure ML Workspace UK South IP
  "51.105.67.16/28",   # Azure ML Workspace UK South IP
  "51.105.75.128/28",  # Azure ML Workspace UK South IP
  "51.140.146.208/28", # Azure ML Workspace UK South IP
  "51.143.214.32/28",  # Azure ML Workspace UK South IP
  "52.151.111.249",    # Azure ML Workspace UK South IP
  "20.3.165.95"        # Document Intelligence Studio
]

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
    partition_count   = 10
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
eventhub_capacity    = 2
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
    deploy_sftp_storage            = true
    use_microsoft_ip_kit_structure = true
    role_based_access_control = [
      {
        name = "prasanna.krishnan@justice.gov.uk"
        type = "User"
      },
      {
        name = "prasanna.krishnan@hmcts.net"
        type = "User"
      },
      {
        name = "Isabella.O'Hara@HMCTS.NET"
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
      },
      {
        name  = "DTS Bootstrap (sub:dts-cftptl-intsvc)"
        type  = "ServicePrincipal"
        roles = ["Contributor"]
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
        computer_name   = "ingest00-legacy"
        public_ip       = true
        source_image_id = "/subscriptions/e9674938-57cb-43ff-a440-1917658e468c/resourceGroups/data-ingest-images-rg/providers/Microsoft.Compute/galleries/dataingest_images/images/windows-2016-sql-server-2008-R2-developer/versions/0.0.1"
        os_disk_size_gb = 512
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
        name = "prasanna.krishnan@hmcts.net"
        type = "User"
      },
      {
        name = "Isabella.O'Hara@HMCTS.NET"
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
        name  = "DTS Crime Legacy Data Migration Admin (env:sandbox)"
        type  = "Group"
        roles = ["Owner", "Storage Blob Data Owner"]
      },
      {
        name  = "DTS Crime Legacy Data Migration User (env:sandbox)"
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
            caching              = "ReadWrite"
            storage_account_type = "Premium_LRS"
          }
        ]
        bootstrap_script = <<-EOF
          #!/bin/bash
          yum install -y cloud-utils-growpart
          growpart /dev/sda 2
          btrfs filesystem resize max /
          
          # Format and mount the data disk
          # Wait for the data disk to be available
          until [ -e /dev/disk/azure/scsi1/lun0 ]; do
            sleep 1
          done
          
          # Get the device name
          DATA_DISK=$(readlink -f /dev/disk/azure/scsi1/lun0)
          
          # Create btrfs filesystem
          mkfs.btrfs -f $DATA_DISK
          
          # Create mount point
          mkdir -p /mnt/data
          
          # Get UUID
          DATA_UUID=$(blkid -s UUID -o value $DATA_DISK)
          
          # Add to fstab for persistent mount
          echo "UUID=$DATA_UUID /mnt/data btrfs defaults 0 2" >> /etc/fstab
          
          # Mount the disk
          mount /mnt/data
        EOF
      }
    }

    gh_runners = {
      "dlrm-ingestionengine" = {
        deploy            = true
        token_vault_id    = "/subscriptions/df72bb30-d6fb-47bd-82ee-5eb87473ddb3/resourceGroups/ingest-mgmt-rg-sbox/providers/Microsoft.KeyVault/vaults/ingest-mgmt-kv-sbox"
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

arm_object_id = "fd6e5281-058b-490f-8c90-186c7f057502"

# AI module settings
ml_compute_instances = 0
