#!/bin/sh

echo "
terraform {
  required_version = \"~> $5\"
}

provider google {
  version = \"$1\"
  project = \"$2\"
  region  = \"$3\"
  zone    = \"$4\"
}

provider google-beta {
  version = \"$1\"
  project = \"$2\"
  region  = \"$3\"
  zone    = \"$4\"
}


# Reserving a new static external IP address
# https://cloud.google.com/compute/docs/ip-addresses/reserve-static-external-ip-address#reserve_new_static
resource google_compute_address \"staticIP\" {
  name         = \"$6\"
  project      = \"$2\"
  region       = \"$3\"
  address_type = \"EXTERNAL\"
}

module develop_environment {
  source                               = \"../../module\"
  project                              = \"$2\"
  region                               = \"$3\"
  name                                 = \"$6\"
  node_pool_autoscaling_min_node_count = $7
  node_pool_autoscaling_max_node_count = $8
  worker_machine_type                  = \"$9\"
}" >./env/dev/main.tf


echo "
terraform {
    backend \"gcs\" {
      bucket = \"${10}\"   
      prefix = \"terraform/state\"
    }
}" >./env/dev/backend.tf


echo "
output develop_output {
  value = module.develop_environment
}
" >./env/dev/outputs.tf



echo "
#https://www.terraform.io/docs/providers/google/r/compute_address.html
terraform import google_compute_address.staticIP \"$2\"/\"$3\"/\"$6\"
" >./env/dev/import.sh



