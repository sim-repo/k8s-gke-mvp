#!/bin/bash

# ./storage
# ./module
#   ./dev
#   ./prod

if [ ! -d ./storage ] 
then
    mkdir -p ./storage
fi

if [ ! -d ./module ] 
then
    mkdir -p ./module
fi

if [ ! -d ./env/dev ] 
then
    mkdir -p ./env/dev
fi

if [ ! -d ./env/prod ] 
then
    mkdir -p ./env/prod
fi