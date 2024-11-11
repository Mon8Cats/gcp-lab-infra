# Create the GCS bucket with configurable options
resource "google_storage_bucket" "my_bucket" {
  project       = var.project_id
  name          = var.bucket_name
  location      = var.location
  storage_class = var.storage_class

  # Enable versioning for state history tracking
  versioning {
    enabled = var.versioning_enabled
  }

  # Set lifecycle rules if specified
  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      action {
        type = lifecycle_rule.value.action_type
      }
      condition {
        age                   = lookup(lifecycle_rule.value.condition, "age", null)
        created_before        = lookup(lifecycle_rule.value.condition, "created_before", null)
        #is_live               = lookup(lifecycle_rule.value.condition, "is_live", null)
        num_newer_versions    = lookup(lifecycle_rule.value.condition, "num_newer_versions", null)
      }
    }
  }

  # Optional: Set retention policy for object locking
  dynamic "retention_policy" {
    for_each = var.enable_retention_policy ? [1] : []
    content {
      retention_period = var.retention_period_days * 86400 # Convert days to seconds
      is_locked        = var.retention_policy_locked
    }
  }
}
