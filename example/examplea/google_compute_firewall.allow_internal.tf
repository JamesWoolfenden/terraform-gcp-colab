resource "google_compute_firewall" "allow_internal" {
  name      = "colab-allow-internal"
  network   = google_compute_network.colab.self_link
  direction = "INGRESS"
  priority  = 1000

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }

  source_ranges = [google_compute_subnetwork.colab.ip_cidr_range]

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }
}
