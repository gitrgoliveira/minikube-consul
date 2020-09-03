#!/usr/bin/env bash

cat ~/.GH_DOCKER_TOKEN | docker login ghcr.io -u gitrgoliveira --password-stdin
docker build --rm webapp/ -t ghcr.io/gitrgoliveira/minikube-consul/webapp:v2
docker push ghcr.io/gitrgoliveira/minikube-consul/webapp:v2