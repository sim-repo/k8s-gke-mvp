#!/bin/bash
cwd=$(pwd)
cd ./storage
terraform destroy
cd $cwd
cd ./env/dev
terraform destroy
cd $cwd
sudo rm -R ./storage
sudo rm -R ./env
sudo rm main.tf
sudo rm -R ./module

