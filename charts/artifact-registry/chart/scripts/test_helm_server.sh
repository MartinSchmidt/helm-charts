#!/bin/bash
set -e

./scripts/install_helm.sh
./scripts/install_kubectl.sh

# Create test chart
mkdir gh-test && cd gh-test && helm create chart

# Package chart
ls && helm package chart && mv chart-0.1.0.tgz /charts 

# Index chart
cd /charts && helm repo index .

kubectl wait --for=condition=ready pod -l app=helm-server --timeout=60s

helm repo add test-registry http://helm-server-service && helm install test-registry/chart --generate-name

rm /charts/* 
