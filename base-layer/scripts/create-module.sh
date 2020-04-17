#!/bin/sh


echo "
data google_container_engine_versions \"engine_versions\" {
  location       = var.region
  version_prefix = \"$7\"
}

resource google_container_cluster \"cluster\" {
  provider                 = google-beta
  name                     = var.name
  location                 = var.region
  remove_default_node_pool = true
  initial_node_count       = 1
  monitoring_service       = \"none\"
  logging_service          = \"none\"
  min_master_version       = data.google_container_engine_versions.engine_versions.latest_master_version

  network_policy {
    enabled  = true
    provider = \"CALICO\"
  }
  addons_config {
    istio_config {
      disabled = true
    }
  }
}

resource google_container_node_pool \"node_pool\" {
  name               = var.name
  location           = var.region
  cluster            = google_container_cluster.cluster.name
  version            = data.google_container_engine_versions.engine_versions.latest_node_version
  initial_node_count = 1
  autoscaling {
    min_node_count = var.node_pool_autoscaling_min_node_count
    max_node_count = var.node_pool_autoscaling_max_node_count
  }

  node_config {
    machine_type = var.worker_machine_type
    disk_size_gb = var.worker_disk_size

    metadata = {
      disable-legacy-endpoints = \"true\"
    }

    oauth_scopes = [
      \"https://www.googleapis.com/auth/devstorage.read_only\",
      \"https://www.googleapis.com/auth/monitoring.write\",
    ]
  }

  timeouts {
    create = \"60m\"
    update = \"60m\"
    delete = \"60m\"
  }
}

" >./module/cluster.tf



echo "
variable project {
    description = \"GCP project ID\"
    type        = string
    default     = \"$1\"
}

variable region {
    description = \"GCP region\"
    type        = string
    default     = \"$2\"
}

variable name {
    description = \"Environment name\"
    type        = string
    default     = \"$3\"
}

variable node_pool_autoscaling_min_node_count {
    description = \"Minimum nodes in cluster = value * availability zones count\"
    type        = number
    default     = $4
}

variable node_pool_autoscaling_max_node_count {
    description = \"Maximum nodes in cluster = value * availability zones count\"
    type        = number
    default     = $5
}

variable worker_machine_type {
    description = \"Worker node's machine type\"
    type        = string
    default     = \"$6\"
}

variable worker_disk_size {
  description = \"Boot disk size (GB) for worker nodes\"
  type        = number
  default     = 20
}
" >./module/variables.tf