variable "env" {
  type        = string
  description = "The environment to deploy resources to."
}

variable "builtFrom" {
  type        = string
  description = "The name of the repository these resources are builtFrom."
}

variable "product" {
  type        = string
  description = "The name of the prodcut this infrastructure supports."
}

variable "landing_zones" {
  description = "The landing zones to deploy."
  type = map(object({
    use_microsoft_ip_kit_structure       = optional(bool, false)
    adf_deploy_purview_private_endpoints = optional(bool, true)
    deploy_bastion                       = optional(bool, false)
    deploy_sftp_storage                  = optional(bool, false)
    role_based_access_control = optional(list(object({
      name  = optional(string)
      type  = optional(string, "user")
      mail  = optional(string),
      roles = optional(list(string), ["Owner"])
    })), [])
    project = string
    gh_runners = optional(map(object({
      deploy            = optional(bool, true)
      token_vault_id    = string
      token_secret_name = string
    })), {})
    legacy_databases = optional(map(object({
      size                = optional(string, "Standard_D4ds_v5")
      type                = optional(string, "windows")
      public_ip           = optional(bool, false)
      computer_name       = optional(string)
      publisher_name      = optional(string)
      offer               = optional(string)
      sku                 = optional(string)
      version             = optional(string)
      source_image_id     = optional(string)
      os_disk_size_gb     = optional(number, 127)
      secure_boot_enabled = optional(bool, true)
      bootstrap_script    = optional(string)
      data_disks = optional(list(object({
        name                 = string
        disk_size_gb         = number
        lun                  = number
        caching              = optional(string, "ReadWrite")
        storage_account_type = optional(string, "StandardSSD_LRS")
      })), [])
    })), {})
    additional_nsg_rules = optional(map(object({
      name_override                              = optional(string)
      priority                                   = number
      direction                                  = string
      access                                     = string
      protocol                                   = string
      source_port_range                          = optional(string)
      source_port_ranges                         = optional(list(string))
      destination_port_range                     = optional(string)
      destination_port_ranges                    = optional(list(string))
      source_address_prefix                      = optional(string)
      source_address_prefixes                    = optional(list(string))
      source_application_security_group_ids      = optional(list(string))
      destination_address_prefix                 = optional(string)
      destination_address_prefixes               = optional(list(string))
      destination_application_security_group_ids = optional(list(string))
      description                                = optional(string)
    })))
    additional_vnet_address_space = optional(list(string), [])
    additional_subnets = optional(map(object({
      name_override     = optional(string)
      address_prefixes  = optional(list(string))
      service_endpoints = optional(list(string), [])
      delegations = optional(map(object({
        service_name = string,
        actions      = optional(list(string), [])
      })))
    })))
  }))
}

variable "default_route_next_hop_ip" {
  type        = string
  description = "The IP address of the next hop in the route table. Should be the Palo Alto load balancer for the given environment."
}

variable "hub_vnet_name" {
  description = "The name of the HUB virtual network."
  type        = string
}

variable "hub_resource_group_name" {
  description = "The name of the resource group containing the HUB virtual network."
  type        = string
}

variable "hub_subscription_id" {
  description = "The ID of the subscription containing the HUB virtual network."
  type        = string
}

variable "arm_object_id" {
  description = "The object id of the Archiving with Records Management service principal."
  type        = string
}
