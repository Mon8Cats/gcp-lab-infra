# Variables for bucket configuration
variable "project_id" {
  description = "The GCP project ID where the bucket will be created"
  type        = string
}

variable "bucket_name" {
  description = "Name of the GCS bucket"
  type        = string
}

variable "location" {
  description = "Location of the GCS bucket"
  type        = string
  default     = "US"
}

variable "storage_class" {
  description = "Storage class of the GCS bucket"
  type        = string
  default     = "STANDARD"
}

variable "versioning_enabled" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = true
}

variable "lifecycle_rules" {
  description = "List of lifecycle rules for the bucket"
  type = list(object({
    action_type   = string
    condition     = map(any)
  }))
  default = [
    {
      action_type = "Delete"
      condition   = {
        age = 365
      }
    }
  ]
}

variable "enable_retention_policy" {
  description = "Enable object locking and retention policy"
  type        = bool
  default     = false
}

variable "retention_period_days" {
  description = "Retention period in days for object locking (only if enable_retention_policy is true)"
  type        = number
  default     = 30
}

variable "retention_policy_locked" {
  description = "Lock the retention policy to prevent deletion of objects"
  type        = bool
  default     = false
}
