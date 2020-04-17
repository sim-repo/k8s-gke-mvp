#!/bin/sh

cur_environment=$1


cwd=$(pwd)

if [[ "$cur_environment" == "dev" ]]; then
  cd ./storage/dev
fi

if [[ "$cur_environment" == "prod" ]]; then
  cd ./storage/prod
fi

terraform init 
terraform apply -auto-approve
cd $cwd


if [[ "$cur_environment" == "dev" ]]; then
  cd ./env/dev
fi

if [[ "$cur_environment" == "prod" ]]; then
  cd ./env/prod
fi

terraform init 
chmod u+x ./import.sh
./import.sh
terraform apply -auto-approve
