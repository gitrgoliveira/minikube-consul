#!/usr/bin/env bash
source helper.sh

CONSUL_HELM_VERSION=0.21.0
helm repo add hashicorp https://helm.releases.hashicorp.com

c1_kctx
helm install cluster-1 hashicorp/consul -f values1.yaml \
    --version $CONSUL_HELM_VERSION \
    --set global.datacenter=cluster-1 \
    --wait
kubectl wait --for=condition=available --timeout=1m deployment.apps/consul-connect-injector-webhook-deployment

kubectl get secret consul-federation -o yaml > consul-federation-secret.yaml

c2_kctx
kubectl apply -f consul-federation-secret.yaml
helm install cluster-2 hashicorp/consul -f values2.yaml \
    --version $CONSUL_HELM_VERSION \
    --set global.datacenter=cluster-2 \
    --wait

kubectl wait --for=condition=available --timeout=1m deployment.apps/consul-connect-injector-webhook-deployment

c1_kctl apply -f apps_cli/
c2_kctl apply -f apps_cli/counting-dashboard.yaml

minikube service list -p cluster-1
minikube service list -p cluster-2
