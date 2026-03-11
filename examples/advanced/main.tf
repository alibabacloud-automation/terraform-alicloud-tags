provider "alicloud" {
  region = "cn-hangzhou"
}

# Separate provider for Shanghai region (for tag policies)
provider "alicloud" {
  alias  = "shanghai"
  region = "cn-shanghai"
}

data "alicloud_account" "current" {}

# Module 1: Testing tag policies and policy attachments (requires cn-shanghai region)
module "tag_policies" {
  source = "../.."
  providers = {
    alicloud = alicloud.shanghai
  }

  tag_policies = {
    "cost_center_policy" = {
      policy_name = "CostCenterPolicy"
      policy_desc = "Enforce CostCenter tag with allowed values"
      policy_content = jsonencode({
        tags = {
          CostCenter = {
            tag_key   = { "@@assign" = "CostCenter" }
            tag_value = { "@@assign" = ["cost-center-123", "cost-center-456"] }
          }
        }
      })
      user_type = "USER"
    }
  }

  tag_policy_attachments = {
    "attach_to_account" = {
      policy_key  = "cost_center_policy"
      target_id   = data.alicloud_account.current.id
      target_type = "USER"
    }
  }
}

# Module 2: Testing meta tags and associated rules (in cn-hangzhou)
module "tag_governance" {
  source = "../.."

  # Register meta tags (predefined tags)
  # Note: alicloud_tag_meta_tag only supports cn-hangzhou region
  tag_meta_tags = {
    "A_PROJECT"      = ["PRJ"]
    "A_REGION"       = ["CN_EAST", "CN_NORTH", "CN_SOUTH"]
    "A_BUDGET"       = ["CORP_BUDGET"]
    "A_RGPD"         = ["BUSINESS", "CONFIDENTIAL", "PERSONAL"]
    "A_INFRA_REGION" = ["DISASTER_RECOVERY", "MAIN"]
    "A_ENVIRONMENT"  = ["DEV", "INT", "LAB", "PRD", "PRE", "TST"]
    Owner            = ["team-alpha", "team-beta", "team-gamma"]
    Team             = ["backend-team", "frontend-team", "platform-team"]
    CostCenter       = ["cost-center-123", "cost-center-456"]
  }

  # Configure associated rules for automatic tag propagation
  tag_associated_rules = {
    "ecs_eni_rule" = {
      setting_name = "rule:AttachEni-DetachEni-TagInstance:Ecs-Instance:Ecs-Eni"
      status       = "Enable"
      tag_keys     = ["user"]
    }
  }
}