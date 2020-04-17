#!/bin/sh



google_provider_version="3.5.0"
project_id="alpine-realm-270323"
region_id="us-central1"
zone_id="us-central1-c" 
bucket_name="my-dev-storage"
terraform_version="0.12"
node_pool_autoscaling_min_node_count=2
node_pool_autoscaling_max_node_count=3
worker_machine_type="n1-standard-2"
cur_environment="dev"
cluster_name="development-188223"
kubernetes_version="1.15."

./scripts/create-dirs.sh
./scripts/create-storage.sh $google_provider_version $project_id $region_id $zone_id $bucket_name
./scripts/create-module.sh $project_id $region_id $cluster_name $node_pool_autoscaling_min_node_count $node_pool_autoscaling_max_node_count $worker_machine_type $kubernetes_version

./scripts/create-dev-cluster.sh $google_provider_version $project_id $region_id $zone_id $terraform_version $cluster_name $node_pool_autoscaling_min_node_count $node_pool_autoscaling_max_node_count $worker_machine_type $bucket_name
./scripts/create-prod-cluster.sh $google_provider_version $project_id $region_id $zone_id $terraform_version $cluster_name $node_pool_autoscaling_min_node_count $node_pool_autoscaling_max_node_count $worker_machine_type $bucket_name

