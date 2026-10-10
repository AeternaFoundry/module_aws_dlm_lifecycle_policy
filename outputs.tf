output "dlm_lifecycle_policies_id" {
  description = "Map of id values across all dlm_lifecycle_policies, keyed the same as var.dlm_lifecycle_policies"
  value       = { for k, v in aws_dlm_lifecycle_policy.dlm_lifecycle_policies : k => v.id if v.id != null && length(v.id) > 0 }
}
output "dlm_lifecycle_policies_arn" {
  description = "Map of arn values across all dlm_lifecycle_policies, keyed the same as var.dlm_lifecycle_policies"
  value       = { for k, v in aws_dlm_lifecycle_policy.dlm_lifecycle_policies : k => v.arn if v.arn != null && length(v.arn) > 0 }
}
output "dlm_lifecycle_policies_default_policy" {
  description = "Map of default_policy values across all dlm_lifecycle_policies, keyed the same as var.dlm_lifecycle_policies"
  value       = { for k, v in aws_dlm_lifecycle_policy.dlm_lifecycle_policies : k => v.default_policy if v.default_policy != null && length(v.default_policy) > 0 }
}
output "dlm_lifecycle_policies_description" {
  description = "Map of description values across all dlm_lifecycle_policies, keyed the same as var.dlm_lifecycle_policies"
  value       = { for k, v in aws_dlm_lifecycle_policy.dlm_lifecycle_policies : k => v.description if v.description != null && length(v.description) > 0 }
}
output "dlm_lifecycle_policies_execution_role_arn" {
  description = "Map of execution_role_arn values across all dlm_lifecycle_policies, keyed the same as var.dlm_lifecycle_policies"
  value       = { for k, v in aws_dlm_lifecycle_policy.dlm_lifecycle_policies : k => v.execution_role_arn if v.execution_role_arn != null && length(v.execution_role_arn) > 0 }
}
output "dlm_lifecycle_policies_policy_details" {
  description = "Map of policy_details values across all dlm_lifecycle_policies, keyed the same as var.dlm_lifecycle_policies"
  value       = { for k, v in aws_dlm_lifecycle_policy.dlm_lifecycle_policies : k => one(v.policy_details) if v.policy_details != null && length(v.policy_details) > 0 }
}
output "dlm_lifecycle_policies_region" {
  description = "Map of region values across all dlm_lifecycle_policies, keyed the same as var.dlm_lifecycle_policies"
  value       = { for k, v in aws_dlm_lifecycle_policy.dlm_lifecycle_policies : k => v.region if v.region != null && length(v.region) > 0 }
}
output "dlm_lifecycle_policies_state" {
  description = "Map of state values across all dlm_lifecycle_policies, keyed the same as var.dlm_lifecycle_policies"
  value       = { for k, v in aws_dlm_lifecycle_policy.dlm_lifecycle_policies : k => v.state if v.state != null && length(v.state) > 0 }
}
output "dlm_lifecycle_policies_tags" {
  description = "Map of tags values across all dlm_lifecycle_policies, keyed the same as var.dlm_lifecycle_policies"
  value       = { for k, v in aws_dlm_lifecycle_policy.dlm_lifecycle_policies : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "dlm_lifecycle_policies_tags_all" {
  description = "Map of tags_all values across all dlm_lifecycle_policies, keyed the same as var.dlm_lifecycle_policies"
  value       = { for k, v in aws_dlm_lifecycle_policy.dlm_lifecycle_policies : k => v.tags_all if v.tags_all != null && length(v.tags_all) > 0 }
}

