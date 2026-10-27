terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 4.81.0"
    }
  }
}

variable "landing_zones" {
  type = map(object({ deploy_function_app = bool }))
}

output "selected_landing_zones" {
  value = toset(keys({ for lz_key, lz in var.landing_zones : lz_key => lz if lz.deploy_function_app }))
}

output "caller_filter_matches" {
  value = strcontains(
    file("${path.module}/../../../../../components/landing/function-app.tf"),
    "for_each = { for lz_key, lz in var.landing_zones : lz_key => lz if lz.deploy_function_app }"
  )
}