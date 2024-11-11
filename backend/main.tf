# doesn't need eanble google storage api?

module "terraform_backend_bucket" {
  source                  = "../modules/s1_gcs_bucket"
  project_id              = var.project_id
  bucket_name             = var.bucket_name
  location                = var.region  #"US", "EU", "ASIA" multi-regional bucket
  storage_class           = "STANDARD" # Nearline, Coldline, Archive
  versioning_enabled      = true
  enable_retention_policy = true
  retention_period_days   = 30
  retention_policy_locked = false
  lifecycle_rules = [
    {
      action_type = "Delete"
      condition   = { age = 365 }
    }
  ]
}
