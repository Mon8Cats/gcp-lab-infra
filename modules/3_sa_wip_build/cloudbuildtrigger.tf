


# Step 7: Create a Cloud Build Trigger
resource "google_cloudbuild_trigger" "github_trigger" {
  location = var.region
  name        = "github-trigger-main-branch-tf"
  description = "Trigger for building and deploying when code is pushed to the main branch"
  
  github {
    owner = var.github_owner
    name = var.github_repo
    push {
      branch = "main" # Only trigger on changes to the main branch
    }
  }

  service_account = google_service_account.ci_service_account.id # id or email?
  filename = "cloudbuild.yaml"
  /* -- it gives an error
  depends_on = [
    google_project_iam_member.act_as,
    google_project_iam_member.logs_writer
  ]
  */

}
