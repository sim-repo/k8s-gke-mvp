
data google_container_engine_versions "engine_versions" {
  location       = var.region
  version_prefix = "1.15."
}

resource google_container_cluster "cluster" {
  provider                 = google-beta
  name                     = var.name
  location                 = var.region
  remove_default_node_pool = true
  initial_node_count       = 1
  monitoring_service       = "none"
  logging_service          = "none"
  min_master_version       = data.google_container_engine_versions.engine_versions.latest_master_version

  network_policy {
    enabled  = true
    provider = "CALICO"
  }
  addons_config {
    istio_config {
      disabled = true
    }
  }
}

resource google_container_node_pool "node_pool" {
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
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/monitoring.write",
    ]
  }

  timeouts {
    create = "60m"
    update = "60m"
    delete = "60m"
  }
}


