variable "dlm_lifecycle_policies" {
  description = <<EOT
Map of dlm_lifecycle_policies, attributes below
Required:
    - description
    - execution_role_arn
    - policy_details (block):
        - action (optional, block):
            - cross_region_copy (required, block):
                - encryption_configuration (required, block):
                    - cmk_arn (optional)
                    - encrypted (optional)
                - retain_rule (optional, block):
                    - interval (required)
                    - interval_unit (required)
                - target (required)
            - name (required)
        - copy_tags (optional)
        - create_interval (optional)
        - event_source (optional, block):
            - parameters (required, block):
                - description_regex (required)
                - event_type (required)
                - snapshot_owner (required)
            - type (required)
        - exclusions (optional, block):
            - exclude_boot_volumes (optional)
            - exclude_tags (optional)
            - exclude_volume_types (optional)
        - extend_deletion (optional)
        - parameters (optional, block):
            - exclude_boot_volume (optional)
            - no_reboot (optional)
        - policy_language (optional)
        - policy_type (optional)
        - resource_locations (optional)
        - resource_type (optional)
        - resource_types (optional)
        - retain_interval (optional)
        - schedule (optional, block):
            - archive_rule (optional, block):
                - archive_retain_rule (required, block):
                    - retention_archive_tier (required, block):
                        - count (optional)
                        - interval (optional)
                        - interval_unit (optional)
            - copy_tags (optional)
            - create_rule (required, block):
                - cron_expression (optional)
                - interval (optional)
                - interval_unit (optional)
                - location (optional)
                - scripts (optional, block):
                    - execute_operation_on_script_failure (optional)
                    - execution_handler (required)
                    - execution_handler_service (optional)
                    - execution_timeout (optional)
                    - maximum_retry_count (optional)
                    - stages (optional)
                - times (optional)
            - cross_region_copy_rule (optional, block):
                - cmk_arn (optional)
                - copy_tags (optional)
                - deprecate_rule (optional, block):
                    - interval (required)
                    - interval_unit (required)
                - encrypted (required)
                - retain_rule (optional, block):
                    - interval (required)
                    - interval_unit (required)
                - target (optional)
                - target_region (optional)
            - deprecate_rule (optional, block):
                - count (optional)
                - interval (optional)
                - interval_unit (optional)
            - fast_restore_rule (optional, block):
                - availability_zones (required)
                - count (optional)
                - interval (optional)
                - interval_unit (optional)
            - name (required)
            - retain_rule (required, block):
                - count (optional)
                - interval (optional)
                - interval_unit (optional)
            - share_rule (optional, block):
                - target_accounts (required)
                - unshare_interval (optional)
                - unshare_interval_unit (optional)
            - tags_to_add (optional)
            - variable_tags (optional)
        - target_tags (optional)
Optional:
    - default_policy
    - region
    - state
    - tags
    - tags_all
EOT

  type = map(object({
    description        = string
    execution_role_arn = string
    default_policy     = optional(string)
    region             = optional(string)
    state              = optional(string)
    tags               = optional(map(string))
    tags_all           = optional(map(string))
    policy_details = object({
      action = optional(object({
        cross_region_copy = list(object({
          encryption_configuration = object({
            cmk_arn   = optional(string)
            encrypted = optional(bool)
          })
          retain_rule = optional(object({
            interval      = number
            interval_unit = string
          }))
          target = string
        }))
        name = string
      }))
      copy_tags       = optional(bool)
      create_interval = optional(number)
      event_source = optional(object({
        parameters = object({
          description_regex = string
          event_type        = string
          snapshot_owner    = set(string)
        })
        type = string
      }))
      exclusions = optional(object({
        exclude_boot_volumes = optional(bool)
        exclude_tags         = optional(map(string))
        exclude_volume_types = optional(list(string))
      }))
      extend_deletion = optional(bool)
      parameters = optional(object({
        exclude_boot_volume = optional(bool)
        no_reboot           = optional(bool)
      }))
      policy_language    = optional(string)
      policy_type        = optional(string)
      resource_locations = optional(list(string))
      resource_type      = optional(string)
      resource_types     = optional(list(string))
      retain_interval    = optional(number)
      schedule = optional(list(object({
        archive_rule = optional(object({
          archive_retain_rule = object({
            retention_archive_tier = object({
              count         = optional(number)
              interval      = optional(number)
              interval_unit = optional(string)
            })
          })
        }))
        copy_tags = optional(bool)
        create_rule = object({
          cron_expression = optional(string)
          interval        = optional(number)
          interval_unit   = optional(string)
          location        = optional(string)
          scripts = optional(object({
            execute_operation_on_script_failure = optional(bool)
            execution_handler                   = string
            execution_handler_service           = optional(string)
            execution_timeout                   = optional(number)
            maximum_retry_count                 = optional(number)
            stages                              = optional(list(string))
          }))
          times = optional(list(string))
        })
        cross_region_copy_rule = optional(list(object({
          cmk_arn   = optional(string)
          copy_tags = optional(bool)
          deprecate_rule = optional(object({
            interval      = number
            interval_unit = string
          }))
          encrypted = bool
          retain_rule = optional(object({
            interval      = number
            interval_unit = string
          }))
          target        = optional(string)
          target_region = optional(string)
        })))
        deprecate_rule = optional(object({
          count         = optional(number)
          interval      = optional(number)
          interval_unit = optional(string)
        }))
        fast_restore_rule = optional(object({
          availability_zones = set(string)
          count              = optional(number)
          interval           = optional(number)
          interval_unit      = optional(string)
        }))
        name = string
        retain_rule = object({
          count         = optional(number)
          interval      = optional(number)
          interval_unit = optional(string)
        })
        share_rule = optional(object({
          target_accounts       = set(string)
          unshare_interval      = optional(number)
          unshare_interval_unit = optional(string)
        }))
        tags_to_add   = optional(map(string))
        variable_tags = optional(map(string))
      })))
      target_tags = optional(map(string))
    })
  }))
  validation {
    condition = alltrue([
      for k, v in var.dlm_lifecycle_policies : (
        v.policy_details.action == null || (length(v.policy_details.action.cross_region_copy) >= 1 && length(v.policy_details.action.cross_region_copy) <= 3)
      )
    ])
    error_message = "Each cross_region_copy list must contain between 1 and 3 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.dlm_lifecycle_policies : (
        v.policy_details.schedule == null || (length(v.policy_details.schedule) <= 4)
      )
    ])
    error_message = "Each schedule list must contain at most 4 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.dlm_lifecycle_policies : (
        v.policy_details.schedule == null || alltrue([for item in v.policy_details.schedule : (item.cross_region_copy_rule == null || (length(item.cross_region_copy_rule) <= 3))])
      )
    ])
    error_message = "Each cross_region_copy_rule list must contain at most 3 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.dlm_lifecycle_policies : (
        v.policy_details.create_interval == null || (v.policy_details.create_interval >= 1 && v.policy_details.create_interval <= 7)
      )
    ])
    error_message = "must be between 1 and 7"
  }
  validation {
    condition = alltrue([
      for k, v in var.dlm_lifecycle_policies : (
        v.policy_details.retain_interval == null || (v.policy_details.retain_interval >= 2 && v.policy_details.retain_interval <= 14)
      )
    ])
    error_message = "must be between 2 and 14"
  }
  # Note: 51 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

