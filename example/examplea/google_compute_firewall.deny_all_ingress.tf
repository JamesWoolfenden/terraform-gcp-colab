# Explicit catch-all deny so the example never relies on GCP's implied default
# ingress rules. Lower priority than colab-allow-internal.
resource "google_compute_firewall" "deny_all_ingress" {
  name      = "colab-deny-all-ingress"
  network   = google_compute_network.colab.self_link
  direction = "INGRESS"
  priority  = 65000

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }

  source_ranges = ["0.0.0.0/0"]

  deny {
    protocol = "all"
  }
}
