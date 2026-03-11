variable "tag_policies" {
  type = map(object({
    policy_name    = string
    policy_desc    = optional(string)
    policy_content = string
    user_type      = optional(string)
  }))
  description = "A map of tag policies to create. The policy_content must be a valid JSON document following the Alibaba Cloud tag policy schema. Valid user_type values: USER, RD."
  default     = {}
}

variable "tag_policy_attachments" {
  type = map(object({
    policy_key  = string
    target_id   = string
    target_type = string
  }))
  description = "A map of tag policy attachments. policy_key references a key from var.tag_policies. Valid target_type values: USER, ROOT, FOLDER, ACCOUNT."
  default     = {}
}

variable "tag_meta_tags" {
  type        = map(list(string))
  description = "Meta tags to register as predefined tags. Each key is a tag key name and the value is a list of allowed tag values. Note: alicloud_tag_meta_tag only supports cn-hangzhou region."
  default     = {}
}

variable "tag_associated_rules" {
  type = map(object({
    setting_name = string
    status       = optional(string, "Enable")
    tag_keys     = optional(list(string))
  }))
  description = "A map of associated resource tag rules for automatic tag propagation. setting_name is the predefined rule identifier (e.g. rule:AttachEni-DetachEni-TagInstance:Ecs-Instance:Ecs-Eni), status must be Enable or Disable."
  default     = {}
}