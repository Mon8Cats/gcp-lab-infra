# What is Workload Identity?

Workload Identity allows you to **securely connect GitHub Actions to GCP services** without using long-lived service account keys. It leverages **OIDC (OpenID Connect)** for authentication, allowing GitHub Actions to **impersonate a GCP service account** based on identity tokens instead of a static key file.

## Why Use Workload Identity?

- **Security**: Avoids storing and managing service account keys.
- **Flexibility**: Easily map GitHub workflows to different GCP service accounts.
- **Short-lived tokens**: Uses OIDC tokens that are short-lived and specific to the job, reducing attack surface.

## How It Works

1. **GitHub OIDC Token Request:**
   
    - When a GitHub Actions job runs, it can request an **OIDC token** from GitHub's OIDC provider.
    - The token contains information about the GitHub repository, branch, and job metadata.

2. **GCP Workload Identity Pool:**

  - GCP uses a **Workload Identity Pool** to trust the GitHub OIDC provider.
  - This pool acts as a bridge between GitHub's identity and GCP's IAM.

3. **Workload Identity Provider:**

- A **Workload Identity Provider** is configured in GCP to specify:
  - The OIDC issuer URL from GitHub (`https://token.actions.githubusercontent.com`).
  - The **allowed audiences**, typically GCP project numbers.
  - Conditions to restrict which GitHub repositories, branches, or environments can use the provider.

4. **Impersonation of GCP Service Account:**

  - The OIDC token is used to authenticate and impersonate a **GCP service account** (e.g., `cicd-service-account`).
  - The GitHub workflow requests this impersonation using the GCP IAM `roles/iam.serviceAccountTokenCreator`.

5. **Access GCP Resources:**

  - Once authenticated, the GitHub job can access GCP services (e.g., Cloud Build, Artifact Registry, GKE) using the permissions granted to the impersonated service account.


## How to Set It Up (High-Level Steps)

### Step 1: Create a Workload Identity Pool and Provider

1. Create a Workload Identity Pool (e.g., `github-identity-pool`).
2. Create a Workload Identity Provider in the pool with:
  - OIDC issuer: `https://token.actions.githubusercontent.com`.
  - Attribute mapping: Map GitHub attributes like repository and branch to GCP attributes.

### Step 2: Create a GCP Service Account for CI/CD

Create a service account (e.g., cicd-service-account) and grant it the required roles:

  - `roles/cloudbuild.builds.builder`
  - `roles/artifactregistry.writer`
  - `roles/run.admin`
  - `roles/container.developer`
  - `roles/iam.serviceAccountTokenCreator`
  
### Step 3: Bind the Service Account to the Workload Identity Pool

Bind the service account to the Workload Identity Pool using an IAM policy binding, allowing the GitHub OIDC identities to impersonate the service account:

```bash
gcloud iam service-accounts add-iam-policy-binding cicd-service-account@your-project.iam.gserviceaccount.com \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/YOUR_PROJECT_NUMBER/locations/global/workloadIdentityPools/github-identity-pool/attribute.repository/YOUR_GITHUB_USER/YOUR_REPOSITORY"
```

### Step 4: Configure GitHub Actions Workflow

In your GitHub Actions workflow, use the OIDC token to authenticate to GCP:

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: read
    steps:
      - name: Authenticate to GCP
        id: auth
        run: |
          gcloud auth login --brief
          gcloud auth print-identity-token
          gcloud auth configure-docker
        env:
          PROJECT_ID: your-project-id
          SERVICE_ACCOUNT: cicd-service-account@your-project-id.iam.gserviceaccount.com
```

### Step 5: Access GCP Services in GitHub Actions

After authentication, you can run commands like:

```bash
gcloud builds submit
gcloud artifacts repositories list
gcloud run deploy
```


## Key Points to Remember

1. **No Static Keys**: You don't need to create and store service account keys in GitHub secrets.
2. **OIDC Token**: GitHub provides a short-lived OIDC token during the workflow run, reducing the risk of exposure.
3. **Impersonation**: GCP service account is impersonated only during the job run, based on the GitHub identity.
4. **Conditions**: You can add conditions (e.g., specific repository or branch) to restrict access further.
This setup enhances the security and flexibility of your CI/CD pipeline from GitHub to GCP Cloud Build. 