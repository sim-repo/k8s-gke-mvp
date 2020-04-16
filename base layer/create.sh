#!/bin/bash

echo -e "#######################################################"
echo -e "#####  WELCOME TO GCP CLUSTER SCRIPT GENERATION    ####"
echo -e "#######################################################"

echo
echo
echo -e "1/6: select environment (dev\prod): "
read cur_environment
echo
echo
echo -e "1/6: enter google provider version: "
read google_provider_version
echo
echo
echo -e "2/6: enter project id: "
read project_id
echo
echo
echo -e "3/6:enter cluster region id: "
read region_id
echo
echo
echo -e "4/6: enter cluster zone id: "
read zone_id
echo
echo
echo -e "5/6: enter bucket storage name: "
read bucket_name
echo
echo
echo -e "6/6: enter terraform version: "
read terraform_version
echo
echo
echo -e "6/6: enter cluster name: "
read cluster_name
echo
echo
echo -e "6/6: enter node_pool_autoscaling_min_node_count: "
read node_pool_autoscaling_min_node_count
echo
echo
echo -e "6/6: enter node_pool_autoscaling_max_node_count: "
read node_pool_autoscaling_max_node_count
echo
echo
echo -e "6/6: worker_machine_type: "
read worker_machine_type

./create-dirs.sh
./create-storage.sh $google_provider_version $project_id $region_id $zone_id $bucket_name
./create-module.sh

if [[ "$cur_environment" == "dev" ]]; then
  ./create-dev-cluster.sh $google_provider_version $project_id $region_id $zone_id $terraform_version $cluster_name $node_pool_autoscaling_min_node_count $node_pool_autoscaling_max_node_count $worker_machine_type $bucket_name
fi

if [[ "$cur_environment" == "prod" ]]; then
  ./create-prod-cluster.sh $google_provider_version $project_id $region_id $zone_id $terraform_version $cluster_name $node_pool_autoscaling_min_node_count $node_pool_autoscaling_max_node_count $worker_machine_type $bucket_name
fi
