# terraform-alicloud-tags

[English](https://github.com/alibabacloud-automation/terraform-alicloud-tags/blob/main/README.md) | 简体中文

用于管理阿里云标签治理的 Terraform 模块。该模块帮助您创建和管理标签策略、预置标签和资源自动关联标签规则，以建立企业级标签治理标准。

## 使用方法

### 基础用法：注册预置标签和配置标签传播规则

```terraform
module "tag_management" {
  source = "alibabacloud-automation/tags/alicloud"

  # 注册预置标签
  # 注意：alicloud_tag_meta_tag 仅支持 cn-hangzhou 地域
  tag_meta_tags = {
    "A_PROJECT"      = ["PRJ", "PRO"]
    "A_ENVIRONMENT"  = ["DEV", "TST"]
    Owner            = ["team-dev", "team-ops"]
  }

  # 配置资源自动关联标签规则
  tag_associated_rules = {
    "ecs_eni_rule" = {
      setting_name = "rule:AttachEni-DetachEni-TagInstance:Ecs-Instance:Ecs-Eni"
      status       = "Enable"
      tag_keys     = ["Owner", "A_PROJECT"]
    }
  }
}
```

### 高级用法：创建标签策略并绑定到账号

```terraform
data "alicloud_account" "current" {}

module "tag_policies" {
  source = "alibabacloud-automation/tags/alicloud"

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
```

## 示例

* [基础示例](https://github.com/alibabacloud-automation/terraform-alicloud-tags/tree/main/examples/basic)
* [高级示例](https://github.com/alibabacloud-automation/terraform-alicloud-tags/tree/main/examples/advanced)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.244.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.244.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_tag_associated_rule.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/tag_associated_rule) | resource |
| [alicloud_tag_meta_tag.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/tag_meta_tag) | resource |
| [alicloud_tag_policy.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/tag_policy) | resource |
| [alicloud_tag_policy_attachment.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/tag_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tag_associated_rules"></a> [tag\_associated\_rules](#input\_tag\_associated\_rules) | A map of associated resource tag rules for automatic tag propagation. setting\_name is the predefined rule identifier (e.g. rule:AttachEni-DetachEni-TagInstance:Ecs-Instance:Ecs-Eni), status must be Enable or Disable. | <pre>map(object({<br/>    setting_name = string<br/>    status       = optional(string, "Enable")<br/>    tag_keys     = optional(list(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_tag_meta_tags"></a> [tag\_meta\_tags](#input\_tag\_meta\_tags) | Meta tags to register as predefined tags. Each key is a tag key name and the value is a list of allowed tag values. Note: alicloud\_tag\_meta\_tag only supports cn-hangzhou region. | `map(list(string))` | `{}` | no |
| <a name="input_tag_policies"></a> [tag\_policies](#input\_tag\_policies) | A map of tag policies to create. The policy\_content must be a valid JSON document following the Alibaba Cloud tag policy schema. Valid user\_type values: USER, RD. | <pre>map(object({<br/>    policy_name    = string<br/>    policy_desc    = optional(string)<br/>    policy_content = string<br/>    user_type      = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_tag_policy_attachments"></a> [tag\_policy\_attachments](#input\_tag\_policy\_attachments) | A map of tag policy attachments. policy\_key references a key from var.tag\_policies. Valid target\_type values: USER, ROOT, FOLDER, ACCOUNT. | <pre>map(object({<br/>    policy_key  = string<br/>    target_id   = string<br/>    target_type = string<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tag_associated_rule_ids"></a> [tag\_associated\_rule\_ids](#output\_tag\_associated\_rule\_ids) | A map of associated rule names to their IDs. |
| <a name="output_tag_meta_tag_ids"></a> [tag\_meta\_tag\_ids](#output\_tag\_meta\_tag\_ids) | A map of meta tag keys to their IDs. |
| <a name="output_tag_policy_attachment_ids"></a> [tag\_policy\_attachment\_ids](#output\_tag\_policy\_attachment\_ids) | A map of tag policy attachment names to their IDs. |
| <a name="output_tag_policy_ids"></a> [tag\_policy\_ids](#output\_tag\_policy\_ids) | A map of tag policy names to their IDs. |
<!-- END_TF_DOCS -->

## 提交问题

如果您在使用此模块时遇到任何问题，请提交一个 [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库中提交问题。

## 作者

由阿里云 Terraform 团队创建和维护(terraform@alibabacloud.com)。

## 许可证

MIT 许可。有关完整详细信息，请参阅 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)
