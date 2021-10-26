#!/bin/bash
apt-get update && apt-get install -y dnsutils > /dev/null 2>&1

timeout 5m bash -c /scripts/check-for-ip.sh

ip=$(kubectl get services dns-services-dns-server-udp -n dns --output jsonpath='{.status.loadBalancer.ingress[0].ip}')

nslookup ns1.garagen $ip
