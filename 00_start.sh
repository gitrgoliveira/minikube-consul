#!/usr/bin/env bash
source helper.sh

minikube start -p cluster-1 --vm=true --driver=virtualbox
minikube start -p cluster-2 --vm=true --driver=virtualbox

eval $(minikube docker-env -p cluster-1)
docker build --rm webapp_v1/ -t webapp:v1
docker build --rm webapp_v2/ -t webapp:v2
eval $(minikube docker-env -p cluster-2)
docker build --rm webapp_v1/ -t webapp:v1
docker build --rm webapp_v2/ -t webapp:v2
eval $(minikube docker-env -p cluster-2 -u)

