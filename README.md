# terraform-alicloud-tags

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-tags/blob/main/README-CN.md)

Terraform module for generating standardized tags and managing tag governance on Alibaba Cloud. This module computes a consistent set of tag key-value pairs based on project metadata such as environment, budget, GDPR classification, and disaster recovery status, and optionally creates tag governance resources including tag policies, meta tags (predefined tags), and associated resource tag rules.

## Usage

### Basic: Generate standardized tags

```terraform
module "tags" {
  source  = "alibabacloud-automation/tags/alicloud"

  geozone           = "cn-hangzhou"
  budget            = "PRODUIT_A"
  project           = "PRJ"
  rgpd_personal     = true
  rgpd_confidential = false
  environment       = "DEV"
  repository        = "my-infra-repo"
}
```

### Advanced: Tag governance with policies and meta tags

```terraform
module "tags" {
  source  = "alibabacloud-automation/tags/alicloud"

  geozone           = "cn-hangzhou"
  budget            = "CORP_BUDGET"
  project           = "PRJ"
  rgpd_personal     = true
  rgpd_confidential = false
  environment       = "PRD"

  # Create a tag policy and attach it to the current account
  tag_policy = {
    enabled     = true
    policy_name = "standard-tag-policy"
    user_type   = "USER"
    policy_content = jsonencode({
      tags = {
        CostCenter = {
          tag_key   = { "@@assign" = "CostCenter" }
          tag_value = { "@@assign" = ["cost-center-123", "cost-center-456"] }
        }
      }
    })
    targets = [
      {
        target_id   = "your-account-id"
        target_type = "USER"
      }
    ]
  }

  # Register standard tags as predefined meta tags (cn-hangzhou only)
  create_meta_tags = true
}
```

## Examples

* [Basic Example](https://github.com/alibabacloud-automation/terraform-alicloud-tags/tree/main/examples/basic)
* [Advanced Example](https://github.com/alibabacloud-automation/terraform-alicloud-tags/tree/main/examples/advanced)

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

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)
