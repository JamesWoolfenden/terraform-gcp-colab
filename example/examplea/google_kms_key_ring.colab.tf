resource "google_kms_key_ring" "colab" {
  name     = "colab-keyring"
  location = "europe-west2"
}
