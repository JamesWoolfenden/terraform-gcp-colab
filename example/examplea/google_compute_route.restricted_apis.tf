# The default 0.0.0.0/0 route is deleted at network creation, so Private Google
# Access needs an explicit route to the restricted VIP range for the runtime to
# reach Google APIs. No general internet egress is added: the runtime template
# sets enable_internet_access = false.
resource "google_compute_route" "restricted_apis" {
  name             = "colab-restricted-googleapis"
  network          = google_compute_network.colab.self_link
  dest_range       = "199.36.153.8/30"
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
}
