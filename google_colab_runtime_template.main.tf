resource "google_colab_runtime_template" "main" {
  name         = var.name
  display_name = var.display_name
  location     = var.location
  description  = var.description
  network_tags = var.network_tags

  machine_spec {
    machine_type = var.machine_type
  }

  data_persistent_disk_spec {
    disk_type    = var.disk_type
    disk_size_gb = var.disk_size_gb
  }

  network_spec {
    enable_internet_access = false
    network                = var.network
    subnetwork             = var.subnetwork
  }

  encryption_spec {
    kms_key_name = var.kms_key_name
  }

  idle_shutdown_config {
    idle_timeout = var.idle_timeout
  }

  shielded_vm_config {
    enable_secure_boot = var.enable_secure_boot
  }

  labels = var.labels

  lifecycle {
    precondition {
      condition     = element(split("/", var.kms_key_name), 3) == var.location
      error_message = "var.kms_key_name must be a key in the same location as var.location; Vertex AI rejects a CMEK key from another region"
    }
  }
}
