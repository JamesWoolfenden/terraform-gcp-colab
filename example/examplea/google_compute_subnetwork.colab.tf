resource "google_compute_subnetwork" "colab" {
  name                     = "colab-subnet"
  ip_cidr_range            = "10.60.0.0/24"
  region                   = "europe-west2"
  network                  = google_compute_network.colab.id
  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}
