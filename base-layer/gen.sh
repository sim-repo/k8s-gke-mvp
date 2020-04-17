#!/bin/sh

echo -e "#######################################################"
echo -e "#####  WELCOME TO GCP CLUSTER SCRIPT GENERATION    ####"
echo -e "#######################################################"


echo -e "1/12: enter k8s version: "
read k8s_version
echo
echo
echo -e "2/12: enter google provider version: "
read google_provider_version
echo
echo
echo -e "3/12: enter terraform version: "
read terraform_version
echo
echo
echo -e "4/12: select environment (dev\prod): "
read cur_environment
echo
echo
echo -e "5/12: enter project id: "
read project_id
echo
echo
echo -e "6/12:enter cluster region id: "
read region_id
echo
echo
echo -e "7/12: enter cluster zone id: "
read zone_id
echo
echo
echo -e "8/12: enter bucket storage name: "
read bucket_name
echo
echo
echo -e "9/12: enter cluster name: "
read cluster_name
echo
echo
echo -e "10/12: enter node_pool_autoscaling_min_node_count: "
read node_pool_autoscaling_min_node_count
echo
echo
echo -e "11/12: enter node_pool_autoscaling_max_node_count: "
read node_pool_autoscaling_max_node_count
echo
echo
echo -e "12/12: worker_machine_type: "
read worker_machine_type

./create-dirs.sh
./create-storage.sh $google_provider_version $project_id $region_id $zone_id $bucket_name
./create-module.sh $project_id $region_id $cluster_name $node_pool_autoscaling_min_node_count $node_pool_autoscaling_max_node_count $worker_machine_type $kubernetes_version

if [[ "$cur_environment" == "dev" ]]; then
  ./create-dev-cluster.sh $google_provider_version $project_id $region_id $zone_id $terraform_version $cluster_name $node_pool_autoscaling_min_node_count $node_pool_autoscaling_max_node_count $worker_machine_type $bucket_name
fi

if [[ "$cur_environment" == "prod" ]]; then
  ./create-prod-cluster.sh $google_provider_version $project_id $region_id $zone_id $terraform_version $cluster_name $node_pool_autoscaling_min_node_count $node_pool_autoscaling_max_node_count $worker_machine_type $bucket_name
fi
