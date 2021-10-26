#!/bin/bash
timeout 5m bash -c /scripts/check-for-ip.sh

echo "$(kubectl get services ingress-traefik -n ingress --output jsonpath='{.status.loadBalancer.ingress[0].ip}')    test-app" >> /etc/hosts
curl -f http://test-app/test
