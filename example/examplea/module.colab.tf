# holden:ignore:HLD_TF_026 — examples intentionally use ../../ to reference the local module root
# holden:ignore:HLD_TF_065: for expansion
module "colab" {
  source       = "../../"
  name         = "example-template"
  display_name = "Example runtime template"
  location     = "europe-west2"
  network      = google_compute_network.colab.id
  subnetwork   = google_compute_subnetwork.colab.id
  kms_key_name = google_kms_crypto_key.colab.id

  depends_on = [google_kms_crypto_key_iam_member.colab_service_agent]
}
