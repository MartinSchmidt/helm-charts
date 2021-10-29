#!/bin/bash
while :; do
  sleep 10
  ip=$(kubectl get services dns-services-dns-server-udp -n dns --output jsonpath='{.status.loadBalancer.ingress[0].ip}')
  if [ ! -z "$ip" ]
  then
    break
  fi
done
