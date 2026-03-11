
output "tag_policy_ids" {
  value       = { for k, v in alicloud_tag_policy.this : k => v.id }
  description = "A map of tag policy names to their IDs."
}

output "tag_policy_attachment_ids" {
  value       = { for k, v in alicloud_tag_policy_attachment.this : k => v.id }
  description = "A map of tag policy attachment names to their IDs."
}

output "tag_meta_tag_ids" {
  value       = { for k, v in alicloud_tag_meta_tag.this : k => v.id }
  description = "A map of meta tag keys to their IDs."
}

output "tag_associated_rule_ids" {
  value       = { for k, v in alicloud_tag_associated_rule.this : k => v.id }
  description = "A map of associated rule names to their IDs."
}
