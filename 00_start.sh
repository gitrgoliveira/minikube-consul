#!/usr/bin/env bash
source helper.sh

minikube start -p cluster-1 --vm=true --driver=hyperkit --cpus=4
minikube start -p cluster-2 --vm=true --driver=hyperkit

# In offline environments you should uncomment the lines below
#
# eval $(minikube docker-env -p cluster-1)
# docker build --rm webapp/ -t ghcr.io/gitrgoliveira/minikube-consul/webapp:v2
# eval $(minikube docker-env -p cluster-2)
# docker build --rm webapp/ -t ghcr.io/gitrgoliveira/minikube-consul/webapp:v2
# eval $(minikube docker-env -p cluster-2 -u)

