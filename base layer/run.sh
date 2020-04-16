#!/bin/bash

cd ./storage
terraform init
terraform apply
cd ..
cd ./env/dev
terraform init 
terraform apply

