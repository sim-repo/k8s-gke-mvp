#!/bin/sh

cwd=$(pwd)
cd ./storage
terraform init
terraform destroy -auto-approve
cd $cwd
cd ./env/dev
terraform init
terraform destroy -auto-approve
cd $cwd
sudo rm -R ./storage
sudo rm -R ./env
sudo rm main.tf
sudo rm -R ./module

