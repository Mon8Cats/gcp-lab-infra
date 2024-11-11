# GitHub and GCP

## Overview

The communication between **GitHub** and **GCP Cloud Build Trigger** is facilitated by **Google Cloud Build GitHub App** or **GitHub OAuth integration**, along with a **Cloud Build connection**. Here’s how it works in detail:

## 1. Cloud Build GitHub App (Recommended Integration)

- **GitHub App Installation**: The integration starts by installing the **Google Cloud Build GitHub App** on your GitHub account or organization. This app handles the necessary permissions and webhooks.
- Webhook Communication: When you push code or create a pull request in GitHub, the GitHub App sends a webhook event to the GCP Cloud Build service.
- **Cloud Build Connection**: In GCP, you create a **Cloud Build Connection** (via UI, `gcloud` CLI, or Terraform) linking your GitHub repository to GCP. This connection uses OAuth credentials and securely connects GCP Cloud Build with GitHub.

## 2. Cloud Build Trigger Setup

- **Webhook Listener**: The Cloud Build service listens for webhook events from the GitHub repository. When an event (e.g., `push` or `pull_request`) is received, the Cloud Build trigger is activated.
- **Trigger Configuration**: The trigger configuration specifies the conditions under which Cloud Build should start a build. For example:
  - Branch or tag filters (`main`, `develop`, `release/*`).
  - Type of event (`push`, `pull request`, `merge`).
- **Cloud Build Execution**: Once the trigger conditions are met, GCP Cloud Build starts the build process. It fetches the code from GitHub using OAuth access granted during the setup of the GitHub App.

## 3. Authentication and Authorization

- **OAuth 2.0 and Workload Identity**: GCP uses **OAuth 2.0** to authenticate the connection between GitHub and GCP. This is established when you create the Cloud Build connection using the **GitHub OAuth token** (generated during the GitHub App setup).
- **Service Account for Builds**: The Cloud Build process uses a **GCP service account** with the necessary roles (e.g., Cloud Build Editor, Artifact Registry Reader) to perform the build tasks.

## 4. Logs and Notifications

- **Webhook Delivery and Logs**: GitHub records the delivery status of webhooks, which can be viewed in the GitHub repository’s settings under **Webhooks**.
- **Cloud Build Logs**: GCP logs the build status and any errors in **Cloud Logging**, which helps in troubleshooting issues.

## Flow Summary

1. **GitHub Commit or PR** → GitHub sends a **webhook** event to GCP.
2. **Webhook Received** → GCP **Cloud Build Trigger receives** the event and checks conditions.
3. **Trigger Activated** → Cloud Build starts a **build** using the configuration defined in `cloudbuild.yaml` or the build steps in the trigger.
4. **Build Execution** → The build process runs using the code from GitHub, and the results are logged in Cloud Build.

## Example Scenario

If you push code to the main branch:

- GitHub sends a **push event** to GCP via the installed GitHub App.
- GCP checks the Cloud Build Trigger configuration.
- If the event matches (e.g., `branch: main`), Cloud Build starts executing the steps defined in `cloudbuild`.yaml.
- Cloud Build fetches the source code, builds the image, and deploys it (e.g., to GKE, Cloud Run).

## Why Use GitHub App Integration?

- **Secure Authentication**: Uses OAuth 2.0, avoiding the need for SSH keys or personal access tokens.
- **Automatic Webhook Setup**: The GitHub App handles webhooks, reducing manual configuration.
- **Granular Permissions**: The GitHub App allows specific permissions for reading repository content and push events.
