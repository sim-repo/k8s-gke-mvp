#!/bin/bash

echo -e "
terraform {
  required_version = \"~> $5\"
}

provider google {
  version = \"$1\"
  project = \"$2\"
  region  = \"$3\"
  zone    = \"$4\"
  credentials = file(\"../../../access-key.json\")
}

provider google-beta {
  version = \"$1\"
  project = \"$2\"
  region  = \"$3\"
  zone    = \"$4\"
  credentials = file(\"../../../access-key.json\")
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


echo -e "
terraform {
    backend \"gcs\" {
      bucket = \"${10}\"   
      prefix = \"terraform/state\"
    }
}" >./env/dev/backend.tf


echo -e "
output develop_output {
  value = module.develop_environment
}
" >./env/dev/outputs.tf


