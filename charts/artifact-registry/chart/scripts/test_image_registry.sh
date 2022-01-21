#!/bin/bash
set -e

./scripts/install_buildah.sh
./scripts/install_kubectl.sh

kubectl wait --for=condition=ready pod -l app=image-registry --timeout=120s

buildah pull alpine 
buildah tag alpine image-registry-service:80/alpine 
buildah push --tls-verify=false image-registry-service:80/alpine 
