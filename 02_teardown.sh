#! /usr/bin/env bash
source helper.sh

c1_kctx
kubectl delete -f apps_cli/
helm uninstall cluster-1

c2_kctx
kubectl delete -f apps_cli/
kubectl delete -f consul-federation-secret.yaml
helm uninstall cluster-2

minikube delete -p cluster-1
minikube delete -p cluster-2
