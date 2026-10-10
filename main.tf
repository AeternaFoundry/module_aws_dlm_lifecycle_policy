resource "aws_dlm_lifecycle_policy" "dlm_lifecycle_policies" {
  for_each = var.dlm_lifecycle_policies

  description        = each.value.description
  execution_role_arn = each.value.execution_role_arn
  default_policy     = each.value.default_policy
  region             = each.value.region
  state              = each.value.state
  tags               = each.value.tags
  tags_all           = each.value.tags_all

  policy_details {
    dynamic "action" {
      for_each = each.value.policy_details.action != null ? [each.value.policy_details.action] : []
      content {
        dynamic "cross_region_copy" {
          for_each = action.value.cross_region_copy
          content {
            encryption_configuration {
              cmk_arn   = cross_region_copy.value.encryption_configuration.cmk_arn
              encrypted = cross_region_copy.value.encryption_configuration.encrypted
            }
            dynamic "retain_rule" {
              for_each = cross_region_copy.value.retain_rule != null ? [cross_region_copy.value.retain_rule] : []
              content {
                interval      = retain_rule.value.interval
                interval_unit = retain_rule.value.interval_unit
              }
            }
            target = cross_region_copy.value.target
          }
        }
        name = action.value.name
      }
    }
    copy_tags       = each.value.policy_details.copy_tags
    create_interval = each.value.policy_details.create_interval
    dynamic "event_source" {
      for_each = each.value.policy_details.event_source != null ? [each.value.policy_details.event_source] : []
      content {
        parameters {
          description_regex = event_source.value.parameters.description_regex
          event_type        = event_source.value.parameters.event_type
          snapshot_owner    = event_source.value.parameters.snapshot_owner
        }
        type = event_source.value.type
      }
    }
    dynamic "exclusions" {
      for_each = each.value.policy_details.exclusions != null ? [each.value.policy_details.exclusions] : []
      content {
        exclude_boot_volumes = exclusions.value.exclude_boot_volumes
        exclude_tags         = exclusions.value.exclude_tags
        exclude_volume_types = exclusions.value.exclude_volume_types
      }
    }
    extend_deletion = each.value.policy_details.extend_deletion
    dynamic "parameters" {
      for_each = each.value.policy_details.parameters != null ? [each.value.policy_details.parameters] : []
      content {
        exclude_boot_volume = parameters.value.exclude_boot_volume
        no_reboot           = parameters.value.no_reboot
      }
    }
    policy_language    = each.value.policy_details.policy_language
    policy_type        = each.value.policy_details.policy_type
    resource_locations = each.value.policy_details.resource_locations
    resource_type      = each.value.policy_details.resource_type
    resource_types     = each.value.policy_details.resource_types
    retain_interval    = each.value.policy_details.retain_interval
    dynamic "schedule" {
      for_each = each.value.policy_details.schedule != null ? each.value.policy_details.schedule : []
      content {
        dynamic "archive_rule" {
          for_each = schedule.value.archive_rule != null ? [schedule.value.archive_rule] : []
          content {
            archive_retain_rule {
              retention_archive_tier {
                count         = archive_rule.value.archive_retain_rule.retention_archive_tier.count
                interval      = archive_rule.value.archive_retain_rule.retention_archive_tier.interval
                interval_unit = archive_rule.value.archive_retain_rule.retention_archive_tier.interval_unit
              }
            }
          }
        }
        copy_tags = schedule.value.copy_tags
        create_rule {
          cron_expression = schedule.value.create_rule.cron_expression
          interval        = schedule.value.create_rule.interval
          interval_unit   = schedule.value.create_rule.interval_unit
          location        = schedule.value.create_rule.location
          dynamic "scripts" {
            for_each = schedule.value.create_rule.scripts != null ? [schedule.value.create_rule.scripts] : []
            content {
              execute_operation_on_script_failure = scripts.value.execute_operation_on_script_failure
              execution_handler                   = scripts.value.execution_handler
              execution_handler_service           = scripts.value.execution_handler_service
              execution_timeout                   = scripts.value.execution_timeout
              maximum_retry_count                 = scripts.value.maximum_retry_count
              stages                              = scripts.value.stages
            }
          }
          times = schedule.value.create_rule.times
        }
        dynamic "cross_region_copy_rule" {
          for_each = schedule.value.cross_region_copy_rule != null ? schedule.value.cross_region_copy_rule : []
          content {
            cmk_arn   = cross_region_copy_rule.value.cmk_arn
            copy_tags = cross_region_copy_rule.value.copy_tags
            dynamic "deprecate_rule" {
              for_each = cross_region_copy_rule.value.deprecate_rule != null ? [cross_region_copy_rule.value.deprecate_rule] : []
              content {
                interval      = deprecate_rule.value.interval
                interval_unit = deprecate_rule.value.interval_unit
              }
            }
            encrypted = cross_region_copy_rule.value.encrypted
            dynamic "retain_rule" {
              for_each = cross_region_copy_rule.value.retain_rule != null ? [cross_region_copy_rule.value.retain_rule] : []
              content {
                interval      = retain_rule.value.interval
                interval_unit = retain_rule.value.interval_unit
              }
            }
            target        = cross_region_copy_rule.value.target
            target_region = cross_region_copy_rule.value.target_region
          }
        }
        dynamic "deprecate_rule" {
          for_each = schedule.value.deprecate_rule != null ? [schedule.value.deprecate_rule] : []
          content {
            count         = deprecate_rule.value.count
            interval      = deprecate_rule.value.interval
            interval_unit = deprecate_rule.value.interval_unit
          }
        }
        dynamic "fast_restore_rule" {
          for_each = schedule.value.fast_restore_rule != null ? [schedule.value.fast_restore_rule] : []
          content {
            availability_zones = fast_restore_rule.value.availability_zones
            count              = fast_restore_rule.value.count
            interval           = fast_restore_rule.value.interval
            interval_unit      = fast_restore_rule.value.interval_unit
          }
        }
        name = schedule.value.name
        retain_rule {
          count         = schedule.value.retain_rule.count
          interval      = schedule.value.retain_rule.interval
          interval_unit = schedule.value.retain_rule.interval_unit
        }
        dynamic "share_rule" {
          for_each = schedule.value.share_rule != null ? [schedule.value.share_rule] : []
          content {
            target_accounts       = share_rule.value.target_accounts
            unshare_interval      = share_rule.value.unshare_interval
            unshare_interval_unit = share_rule.value.unshare_interval_unit
          }
        }
        tags_to_add   = schedule.value.tags_to_add
        variable_tags = schedule.value.variable_tags
      }
    }
    target_tags = each.value.policy_details.target_tags
  }
}

