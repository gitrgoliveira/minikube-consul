# Local Consul Demos

*Please READ the Requirements section!*

## Overview

The objective of this repo is to display the possibilities of the different Consul gateways in a kubernetes environments

The steps are based in the fantastic work done at https://learn.hashicorp.com/consul/kubernetes/mesh-gateways

For more information, please visit https://www.consul.io/docs/connect/wan-federation-via-mesh-gateways


## Requirements

1. kubectl
2. minikube
3. helm
4. Consul 1.8.0+ cli
5. an internet connection

## Mesh Gateway Federation

This will use the Mesh Gateway to federate the clusters, install an application, for the gateway to forward the traffic.

To start this demo, follow:

1. `./00_start.sh`
2. `./01_setup.sh`

At the end of the *setup*, you'll see the address of all exposed services of each cluster:
   * consul-ui
   * dashboard-service

**NOTE:** *consul-ui will show up wth `http` instead of `https`*

**NOTE2:** *the values.yaml files are altered to be compatible with minikube and not a recommended production setup*

Use `02_teardown.sh` to remove it all from your machine.

