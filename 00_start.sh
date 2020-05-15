#!/usr/bin/env bash
source helper.sh

minikube start -p cluster-1
minikube start -p cluster-2

c1_kctx