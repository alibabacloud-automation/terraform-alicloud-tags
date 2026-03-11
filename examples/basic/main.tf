provider "alicloud" {
  region = "cn-hangzhou"
}

module "tag_management" {
  source = "../.."

  # Register meta tags (predefined tags)
  # Note: alicloud_tag_meta_tag only supports cn-hangzhou region
  tag_meta_tags = {
    "A_PROJECT"      = ["PRJ", "PRO"]
    "A_REGION"       = ["CN_EAST", "CN_NORTH"]
    "A_BUDGET"       = ["PROJECT_BUDGET"]
    "A_RGPD"         = ["BUSINESS", "CONFIDENTIAL"]
    "A_INFRA_REGION" = ["MAIN"]
    "A_ENVIRONMENT"  = ["DEV", "TST"]
    Owner            = ["team-dev", "team-ops"]
  }

  # Configure associated rules for automatic tag propagation
  tag_associated_rules = {
    "ecs_eni_rule" = {
      setting_name = "rule:AttachEni-DetachEni-TagInstance:Ecs-Instance:Ecs-Eni"
      status       = "Enable"
      tag_keys     = ["Owner", "A_PROJECT"]
    }
  }
}
