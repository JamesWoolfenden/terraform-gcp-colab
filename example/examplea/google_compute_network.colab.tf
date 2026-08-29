resource "google_compute_network" "colab" {
  name                            = "colab-network"
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
}
