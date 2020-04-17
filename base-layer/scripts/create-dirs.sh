#!/bin/sh

# ./storage
#   ./dev
#   ./prod

# ./module
#   ./dev
#   ./prod

if [ ! -d ./storage/dev ] 
then
    mkdir -p ./storage/dev
fi

if [ ! -d ./storage/prod ] 
then
    mkdir -p ./storage/prod
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