
output "tag_policy_ids" {
  value       = module.tag_policies.tag_policy_ids
  description = "A map of tag policy names to their IDs."
}

output "tag_policy_attachment_ids" {
  value       = module.tag_policies.tag_policy_attachment_ids
  description = "A map of tag policy attachment names to their IDs."
}

output "tag_meta_tag_ids" {
  value       = module.tag_governance.tag_meta_tag_ids
  description = "A map of meta tag keys to their IDs."
}

output "tag_associated_rule_ids" {
  value       = module.tag_governance.tag_associated_rule_ids
  description = "A map of associated rule names to their IDs."
}
