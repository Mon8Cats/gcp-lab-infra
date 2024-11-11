# My CICD Project Plan

Setting up a Cloud Run application with a comprehensive CI/CD pipeline using Terraform and GCP infrastructure.

## Step 1: Initial Terraform Backend Setup

- Task: Create a Google Cloud Storage bucket for Terraform backend and a Cloud Secret for storing the GitHub account secret (e.g., Personal Access Token).

- Suggestions:

  1. Backend Configuration:

    - Use a versioned Google Cloud Storage (GCS) bucket for the Terraform state file to enable state file history.
    - Enable object locking and retention policies on the GCS bucket for added security.

  2. Secret Management:

    - Use **Secret Manager** to store sensitive data (e.g., GitHub secrets, API keys) and access them directly in Terraform using the 
       - `google_secret_manager_secret` and 
       - `google_secret_manager_secret_version` resources.

    - Store your GitHub personal access token, any database credentials, and API keys in Secret Manager instead of hardcoding them in Terraform files.

  3. Terraform Initialization:

    - Ensure that the Terraform backend configuration is stored in a separate file (e.g., backend.tf) and is properly initialized before running any Terraform commands.
  
## Step 2: Initial Infrastructure Setup (Manual Terraform Execution)

  - **Task**: Manually execute Terraform to create foundational infrastructure:
    - VPC, subnets, and firewall rules
    - Service account for CI/CD pipeline
    - Workload Identity Pool and Provider for GitHub authentication
    - Cloud Build connection and trigger setup for subsequent CI/CD

### Suggestions:

    1. Isolate Networking Resources:
        - Create a dedicated VPC with subnets in different regions if you plan to deploy services in multiple regions.
        - Use firewall rules to restrict access based on the principle of least privilege.    
    2. Service Account Permissions:
        - Assign the minimum required roles to each service account. For example:
            - Cloud Build SA: `roles/cloudbuild.builds.builder`
            - Artifact Registry access: `roles/artifactregistry.reader` and `roles/artifactregistry.writer`
            - Cloud Run deployment: `roles/run.admin`
            - 
    3. Workload Identity Federation:

        - Use Workload Identity Federation to link GitHub identity to GCP service accounts without requiring long-lived credentials. This is a secure and scalable approach.

    4. Cloud Build Connection Setup:

        - Use the gcloud CLI or Terraform for creating the Cloud Build GitHub connection (google_cloudbuildv2_connection).
        - Ensure that the connection is created in the same region as your Cloud Build triggers.

## Step 3: GitHub Repository for Infrastructure (my-repo-infra)

    - **Task**: Store all Terraform configurations for creating additional GCP resources (e.g., Cloud Run, service accounts) in a GitHub repo. Use a Cloud Build trigger for automated execution.

### Suggestions:

    1. Modularize Terraform Configuration:

        - Use a modular approach in Terraform to keep your configuration DRY (Don't Repeat Yourself). Split the configuration into modules for:
            - Network (VPC, subnets)
            - IAM (service accounts, roles, permissions)
            - Cloud Run (deployment, service configuration)
            - Cloud Build (triggers, connection setup)
        - This will make your configuration reusable and maintainable.

    2. Lock State Files:
        - Enable state file locking using Google Cloud Storage backend and ensure that only one Terraform process can modify the state at a time.

    3. Cloud Build Trigger for Terraform:
        - Create a Cloud Build trigger that listens to changes in the my-repo-infra GitHub repository and automatically runs Terraform to apply infrastructure changes.
        - Ensure the trigger runs in a dedicated environment (e.g., a specific GKE node pool or Cloud Run service) with minimal permissions.

## Step 4: GitHub Repository for Application (my-repo-app)

- **Task**: Store application code in a separate GitHub repo and set up a CI/CD pipeline for building, testing, and deploying the app using Cloud Build.
Suggestions:

1. Application CI/CD Pipeline:

    - Define a `cloudbuild.yaml` for the application that includes:
        - **Build step**: Build a Docker image and push it to Artifact Registry.
        - **Test step**: Run unit tests or integration tests on the application.
        - **Deploy step**: Deploy the Docker image to Cloud Run.
    - Use environment variables or Cloud Build substitutions (e.g., `$BRANCH_NAME`, `$BUILD_ID`) for dynamic configuration.

2. GitHub Workflow Integration:

    - Optionally, integrate GitHub Actions with Cloud Build triggers for an additional layer of automation and feedback. For example, you can use GitHub Actions to validate pull requests before merging them into the main branch.

3. Deployment Strategy:

    - Use **Blue-Green Deployment** or **Canary Deployment** strategies for safer deployments, minimizing the impact of potential failures.
    - Enable **Cloud Run revisions** to allow easy rollbacks in case of issues.

4. Monitoring and Alerts:

    - Set up **Cloud Monitoring** and **Logging** to track your application’s performance.
    - Enable alerts for build failures or deployment issues using Cloud Build notifications integrated with Slack, email, or other notification channels.

## Best Practices Summary:

1. **Modular Infrastructure**: Use Terraform modules for better organization and reusability.
2. **Security**: Use Workload Identity Federation, avoid storing secrets in GitHub, and use IAM roles with the least privilege.
3. **Automation**: Automate infrastructure setup and application deployment using Cloud Build triggers and Terraform.
4. **Testing**: Include automated tests (unit and integration tests) in your CI/CD pipeline to catch issues early.
5. **Rollback and Recovery**: Enable revision history and use deployment strategies that allow quick rollbacks.