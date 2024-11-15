# Clarifying the Flow: GitHub Integration with GCP Using Cloud Build, Workload Identity, and Service Accounts

Your question touches on a typical CI/CD pipeline setup involving GitHub, Google Cloud Build, and GCP service accounts. Let’s break it down step by step to clarify the flow and roles involved:

1. **GitHub Account and Push/Merge Action:**

- **Who triggers the action?**
    - A developer (GitHub account) who is a collaborator in your GitHub repository **pushes code** or **merges a pull request**.
- **What happens next?**
    - The **push/merge** event triggers a **Cloud Build Trigger** in GCP if it matches the configured branch or tag pattern.

2. **Cloud Build Trigger and Workload Identity Federation:**
   
- **Who impersonates the GCP service account?**
    - The **GitHub Actions runner** (from the GitHub account that initiated the push/merge) **does not directly impersonate** a GCP service account.
    - Instead, the **Cloud Build Trigger** is configured to use a **Workload Identity Federation (WIF)** setup that maps the GitHub identity to a **GCP service account**. This allows the GitHub Actions runner to **authenticate** to GCP without using a **service account key**.

- **How does Workload Identity work here?**
    - The GitHub identity (based on repository and branch) is mapped to a **Workload Identity Pool Provider** in GCP.
    - The Workload Identity Pool Provider is linked to a specific **GCP service account** (e.g., infra-service-account@win-gke-cicd.iam.gserviceaccount.com).
    - This service account is impersonated during the execution of the **Cloud Build Trigger**.

3. **Cloud Build Trigger Copies the Code from GitHub to GCP:**
- **How is the code made available to Cloud Build?**
    - When the Cloud Build Trigger is initiated, it connects to the **GitHub repository** using the repository connection configured in GCP (e.g., via GitHub App or OAuth).
    - The source code is **pulled (copied)** from GitHub to a temporary storage location in GCP (gs://<BUCKET>), where it is accessible for the build process.

4. **Execution of `cloudbuild.yaml` Steps:**
- **Who executes the steps in `cloudbuild.yaml`?**
    - The steps defined in `cloudbuild.yaml` are executed by the **service account** specified in the Cloud Build Trigger configuration or in `cloudbuild.yaml` itself (using the `serviceAccount` field).
    - If you have configured a **custom service account** (e.g., infra-service-account@win-gke-cicd.iam.gserviceaccount.com), it will be used to execute all the steps in `cloudbuild.yaml`.
    - If no custom service account is specified, the **default Cloud Build service account** (<PROJECT_NUMBER>@cloudbuild.gserviceaccount.com) is used.

## Summary of the Flow:

1. GitHub Push/Merge:

A GitHub user pushes/merges code in the GitHub repository.
2. Cloud Build Trigger Activation:

The Cloud Build Trigger in GCP is activated by the GitHub push/merge event.

3. Workload Identity Federation:

The GitHub identity is mapped to a GCP service account (e.g., infra-service-account), allowing secure, keyless access.

5. Code Retrieval:

The source code is pulled from GitHub to GCP, making it available for Cloud Build.

6. Build Execution (cloudbuild.yaml Steps):

The steps in cloudbuild.yaml are executed by the specified GCP service account (infra-service-account or default Cloud Build service account).

## Key Points to Remember:

- **Workload Identity Federation** eliminates the need for service account keys, making the integration more secure.  
- The **GitHub user account** does not directly impersonate the GCP service account. Instead, the GitHub identity is mapped via the Workload Identity Pool to a GCP service account.
- The **GCP service account** specified in the Cloud Build Trigger or `cloudbuild.yaml` executes all build steps, including accessing secrets and deploying to services.