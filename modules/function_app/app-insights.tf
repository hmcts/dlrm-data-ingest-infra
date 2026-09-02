module "application_insights" {
  source = "github.com/hmcts/terraform-module-application-insights?ref=4.x"

  product             = "data-landing-fa"
  env                 = var.env
  resource_group_name = var.resource_group_name
  common_tags         = var.common_tags
}
