
output "tag_meta_tag_ids" {
  value       = module.tag_management.tag_meta_tag_ids
  description = "A map of meta tag keys to their IDs."
}

output "tag_associated_rule_ids" {
  value       = module.tag_management.tag_associated_rule_ids
  description = "A map of associated rule names to their IDs."
}

