#! /usr/bin/env bash
source helper.sh

removehost dashboard-service.ingress.cluster-1.consul
removehost dashboard-service.ingress.cluster-2.consul
removehost webapp.ingress.consul
removehost webapp.ingress.cluster-2.consul
removehost webapp-1.ingress.consul
removehost webapp-2.ingress.consul
removehost webapp-3.ingress.consul

# c1_kctx
# kubectl delete -f k8s_manifests/
# helm uninstall cluster-1

# c2_kctx
# kubectl delete -f k8s_manifests/
# kubectl delete -f consul-federation-secret.yaml
# helm uninstall cluster-2

minikube delete -p cluster-1
minikube delete -p cluster-2
docker-compose down -v
