# The default 0.0.0.0/0 route is deleted at network creation, so Private Google
# Access needs an explicit route to the private.googleapis.com VIP range
# (199.36.153.8/30) for the runtime to reach Google APIs. No general internet
# egress is added: the runtime template sets enable_internet_access = false.
# Use restricted.googleapis.com (199.36.153.4/30) here and in the DNS records
# instead if the project sits inside a VPC Service Controls perimeter.
resource "google_compute_route" "private_apis" {
  name             = "colab-private-googleapis"
  network          = google_compute_network.colab.self_link
  dest_range       = "199.36.153.8/30"
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
}
