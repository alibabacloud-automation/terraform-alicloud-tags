resource "alicloud_tag_policy" "this" {
  for_each = var.tag_policies

  policy_name    = each.value.policy_name
  policy_desc    = each.value.policy_desc
  policy_content = each.value.policy_content
  user_type      = each.value.user_type
}

resource "alicloud_tag_policy_attachment" "this" {
  for_each = var.tag_policy_attachments

  policy_id   = alicloud_tag_policy.this[each.value.policy_key].id
  target_id   = each.value.target_id
  target_type = each.value.target_type
}

resource "alicloud_tag_meta_tag" "this" {
  for_each = var.tag_meta_tags

  key    = each.key
  values = each.value
}

resource "alicloud_tag_associated_rule" "this" {
  for_each = var.tag_associated_rules

  status                  = each.value.status
  associated_setting_name = each.value.setting_name
  tag_keys                = each.value.tag_keys
}
