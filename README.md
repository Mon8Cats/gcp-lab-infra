# PostgreSQL Cloud SQL Terraform Module with Google Cloud Build

## Overview

This repository provides a **Terraform module** for creating a **PostgreSQL Cloud SQL instance** on **Google Cloud Platform (GCP)**. The module securely retrieves the database username and password from **Google Cloud Secret Manager**. It is designed to be deployed using **Google Cloud Build** as part of a CI/CD pipeline.

## Features

- Creates a PostgreSQL Cloud SQL instance with customizable configuration.
- Securely retrieves `db_user` and `db_password` from Google Cloud Secret Manager.
- Supports optional private IP configuration.
- Integrates seamlessly with Cloud Build for automated deployment.

## Prerequisites

1. Ensure you have a GCP project with the following APIs enabled:
   - [Cloud SQL Admin API](https://console.cloud.google.com/flows/enableapi?apiid=sqladmin.googleapis.com): `sqladmin.googleapis.com`
   - [Secret Manager API](https://console.cloud.google.com/flows/enableapi?apiid=secretmanager.googleapis.com): `secretmanager.googleapis.com`
2. Create a **service account** (`cicd-sa`) for Cloud Build with the required permissions:
   - `roles/cloudsql.admin`
   - `roles/secretmanager.secretAccessor`
   - `roles/iam.serviceAccountUser` (if using IAM authentication)
   - `roles/viewer`

## IAM Role Assignment

Run the following commands to grant the necessary permissions to the Cloud Build service account:

```bash
gcloud projects add-iam-policy-binding <your-project-id> \
    --member="serviceAccount:cicd-sa@<your-project-id>.iam.gserviceaccount.com" \
    --role="roles/cloudsql.admin"

gcloud projects add-iam-policy-binding <your-project-id> \
    --member="serviceAccount:cicd-sa@<your-project-id>.iam.gserviceaccount.com" \
    --role="roles/secretmanager.secretAccessor"

gcloud projects add-iam-policy-binding <your-project-id> \
    --member="serviceAccount:cicd-sa@<your-project-id>.iam.gserviceaccount.com" \
    --role="roles/iam.serviceAccountUser"
```

## Storing Secrets in Google Cloud Secret Manager

Store your database credentials (db_user and db_password) in Secret Manager:

```bash
# Store the database username
echo -n "my_user" | gcloud secrets create db_user --data-file=-

# Store the database password
echo -n "my_secure_password" | gcloud secrets create db_password --data-file=-

```

Grant access to the Cloud Build service account:

```bash
gcloud secrets add-iam-policy-binding db_user \
    --member="serviceAccount:cicd-sa@<your-project-id>.iam.gserviceaccount.com" \
    --role="roles/secretmanager.secretAccessor"

gcloud secrets add-iam-policy-binding db_password \
    --member="serviceAccount:cicd-sa@<your-project-id>.iam.gserviceaccount.com" \
    --role="roles/secretmanager.secretAccessor"
```

## Terraform Module Usage

Include the cloud_sql_postgres module in your Terraform configuration:

```hcl
module "cloud_sql_postgres" {
  source            = "../../m7_cloud_sql_postgres"
  project_id        = var.project_id
  region            = var.project_region
  instance_name     = "my-postgres-instance"
  database_name     = "my_database"
  db_user           = data.google_secret_manager_secret_version.db_user.secret_data
  db_password       = data.google_secret_manager_secret_version.db_password.secret_data
  tier              = "db-f1-micro"
  database_version  = "POSTGRES_14"
  enable_private_ip = false
  availability_type = "ZONAL"
}
```

## Variables

- project_id: GCP Project ID.
- region: GCP region for the Cloud SQL instance.
- instance_name: Name of the Cloud SQL instance.
- database_name: Name of the PostgreSQL database.
- db_user: Database username (retrieved from Secret Manager).
- db_password: Database password (retrieved from Secret Manager).
- tier: Cloud SQL instance tier (e.g., db-f1-micro).
- database_version: PostgreSQL version (e.g., POSTGRES_14).
- enable_private_ip: Enable private IP (default: false).
- availability_type: Availability type (ZONAL or REGIONAL).

## Cloud Build Configuration

Here’s an example Cloud Build configuration (cloudbuild.yaml) for deploying the Terraform module:

```yaml
steps:
  - name: hashicorp/terraform
    entrypoint: /bin/sh
    args:
      - "-c"
      - |
        terraform init
        terraform apply -auto-approve

```

### Trigger Configuration

Set up a Cloud Build trigger to automatically run the deployment when changes are pushed to your GitHub repository.

## Connecting to Cloud SQL

Use the following connection string in your Flask application:

```python
DB_USER = "my_user"
DB_PASSWORD = "my_secure_password"
DB_NAME = "my_database"
DB_CONNECTION_NAME = "your-project-id:us-central1:my-postgres-instance"

SQLALCHEMY_DATABASE_URI = (
    f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@/"
    f"{DB_NAME}?host=/cloudsql/{DB_CONNECTION_NAME}&sslmode=require"
)

```
