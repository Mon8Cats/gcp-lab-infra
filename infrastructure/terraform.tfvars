project_id = "${env.PROJECT_ID}" #"mon8cats-cloud-lab"
//project_number = "650839457214"
project_region     = "${env.REGION}" # "us-central1"

bucket_name = "mon8cats-lab-tf-backend" # unique


api_list   = [
    "storage.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "cloudbuild.googleapis.com",
    "artifactregistry.googleapis.com",
    "secretmanager.googleapis.com",
    "cloudresourcemanager.googleapis.com",

    "compute.googleapis.com",          # Compute Engine API
    "run.googleapis.com",              # Cloud Run API
    "cloudfunctions.googleapis.com",   # Cloud Functions API
    "container.googleapis.com",        # Kubernetes Engine API
    "appengine.googleapis.com",        # App Engine Admin API
    #"cloudresourcemanager.googleapis.com", # Resource Manager API
    # Add or remove APIs as needed
  ]