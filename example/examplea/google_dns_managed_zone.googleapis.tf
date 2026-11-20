# Private zone so *.googleapis.com resolves to the private VIP range that
# google_compute_route.private_apis routes, rather than to public API
# addresses this network has no route to.
resource "google_dns_managed_zone" "googleapis" {
  name        = "colab-googleapis"
  dns_name    = "googleapis.com."
  description = "Private Google Access resolution for the Colab network"
  visibility  = "private"

  cloud_logging_config {
    enable_logging = true
  }

  private_visibility_config {
    networks {
      network_url = google_compute_network.colab.self_link
    }
  }
}
