
terraform {
  required_version = "~> 0.12"
}

provider google {
  version = "3.5.0"
  project = "alpine-realm-270323"
  region  = "us-east1"
  zone    = "us-east1-a"
}

provider google-beta {
  version = "3.5.0"
  project = "alpine-realm-270323"
  region  = "us-east1"
  zone    = "us-east1-a"
}

# Reserving a new static external IP address
# https://cloud.google.com/compute/docs/ip-addresses/reserve-static-external-ip-address#reserve_new_static
resource google_compute_address "staticIP" {
  name         = "production-188223"
  project      = "alpine-realm-270323"
  region       = "us-east1"
  address_type = "EXTERNAL"
}

module prod_environment {
  source                               = "../../module"
  project                              = "alpine-realm-270323"
  region                               = "us-east1"
  name                                 = "production-188223"
  node_pool_autoscaling_min_node_count = 2
  node_pool_autoscaling_max_node_count = 3
  worker_machine_type                  = "n1-standard-2"
}
