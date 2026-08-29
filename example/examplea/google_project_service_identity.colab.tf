resource "google_project_service_identity" "colab" {
  provider = google-beta
  service  = "aiplatform.googleapis.com"
}
