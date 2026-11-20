variable "name" {
  type        = string
  description = "Resource ID of the Colab Enterprise runtime template"

  validation {
    condition     = can(regex("^[a-z][-a-z0-9]{0,62}$", var.name))
    error_message = "var.name must be lowercase and start with a letter"
  }
}

variable "display_name" {
  type        = string
  description = "Display name of the runtime template"

  validation {
    condition     = length(trimspace(var.display_name)) > 0
    error_message = "var.display_name must be a non-empty string"
  }
}

variable "location" {
  type        = string
  description = "Region of the runtime template"
  default     = "europe-west2"

  validation {
    condition     = length(trimspace(var.location)) > 0
    error_message = "var.location must be a non-empty string"
  }
}

variable "network" {
  type        = string
  description = "Resource ID of the VPC network the runtime attaches to, e.g. google_compute_network.x.id"

  validation {
    condition     = length(trimspace(var.network)) > 0
    error_message = "var.network must be a non-empty string"
  }
}

variable "subnetwork" {
  type        = string
  description = "Resource ID of the subnetwork the runtime attaches to, e.g. google_compute_subnetwork.x.id"

  validation {
    condition     = length(trimspace(var.subnetwork)) > 0
    error_message = "var.subnetwork must be a non-empty string"
  }
}

variable "kms_key_name" {
  type        = string
  description = "Resource name of the Cloud KMS key used to encrypt runtime disks (CMEK)"

  validation {
    condition     = can(regex("^projects/[^/]+/locations/[^/]+/keyRings/[^/]+/cryptoKeys/[^/]+$", var.kms_key_name))
    error_message = "var.kms_key_name must be a full key resource ID: projects/<project>/locations/<location>/keyRings/<ring>/cryptoKeys/<key>"
  }
}

variable "machine_type" {
  type        = string
  description = "Machine type of the runtime"
  default     = "e2-standard-4"

  validation {
    condition     = length(trimspace(var.machine_type)) > 0
    error_message = "var.machine_type must be a non-empty string"
  }
}

variable "disk_size_gb" {
  type        = number
  description = "Size of the persistent data disk, in GB"
  default     = 100

  validation {
    condition     = var.disk_size_gb >= 10 && var.disk_size_gb <= 65536
    error_message = "var.disk_size_gb must be between 10 and 65536"
  }
}

variable "idle_timeout" {
  type        = string
  description = "How long a runtime may be idle before it is shut down, in seconds with an s suffix"
  default     = "3600s"

  validation {
    condition     = can(regex("^[0-9]+s$", var.idle_timeout)) && tonumber(trimsuffix(var.idle_timeout, "s")) >= 600 && tonumber(trimsuffix(var.idle_timeout, "s")) <= 86400
    error_message = "var.idle_timeout must be a duration in seconds between 600s (10m) and 86400s (24h); 0s would disable idle shutdown entirely"
  }
}

variable "description" {
  type        = string
  description = "Description of the runtime template"
  default     = "Managed by Terraform"

  validation {
    condition     = length(trimspace(var.description)) > 0
    error_message = "var.description must be a non-empty string"
  }
}

variable "labels" {
  type        = map(string)
  description = "Labels applied to the runtime template"
  default     = {}

  validation {
    condition     = alltrue([for k, v in var.labels : can(regex("^[a-z][a-z0-9_-]{0,62}$", k))])
    error_message = "var.labels keys must be lowercase and start with a letter"
  }
}

variable "disk_type" {
  type        = string
  description = "Persistent disk type for the runtime data disk"
  default     = "pd-standard"

  validation {
    condition     = contains(["pd-standard", "pd-balanced", "pd-ssd"], var.disk_type)
    error_message = "var.disk_type must be one of pd-standard, pd-balanced, pd-ssd"
  }
}

variable "network_tags" {
  type        = list(string)
  description = "Network tags applied to the runtime, for targeting firewall rules"
  default     = []

  validation {
    condition     = alltrue([for t in var.network_tags : can(regex("^[a-z]([-a-z0-9]{0,61}[a-z0-9])?$", t))])
    error_message = "var.network_tags entries must be lowercase, start with a letter, and be at most 63 characters"
  }
}

variable "enable_secure_boot" {
  type        = bool
  description = "Enable Shielded VM secure boot on runtimes created from the template"
  default     = true
}
