#!/bin/sh

cur_environment=$1

cwd=$(pwd)

echo "######################"
echo "## DELETE CLUSTER.. ##"
echo "######################"
if [[ "$cur_environment" == "dev" ]]; then
  cd ./env/dev
fi

if [[ "$cur_environment" == "prod" ]]; then
  cd ./env/prod
fi
terraform init
terraform destroy -auto-approve

cd $cwd

echo "#######################"
echo "## DELETE STORAGE.. ##"
echo "######################"
if [[ "$cur_environment" == "dev" ]]; then
  cd ./storage/dev
fi

if [[ "$cur_environment" == "prod" ]]; then
  cd ./storage/prod
fi

terraform init
chmod u+x ./import.sh
./import.sh
terraform destroy -auto-approve


