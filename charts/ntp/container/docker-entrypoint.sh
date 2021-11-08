#!/bin/bash
set -o errexit

case "${1}" in
  client)
    if [ -z "NTP_SERVER" ] || [ -z "NTP_SERVERS" ]; then
      echo "Please set \$NTP_SERVER and \$NTP_SERVERS"
      exit 1
    fi
    sed -e "s/{{NTP_SERVER}}/$NTP_SERVER/" -e "s/{{NTP_SERVERS}}/$NTP_SERVERS/" -i /etc/chrony/chrony-client.conf
    exec chronyd -U -d -f /etc/chrony/chrony-client.conf
    ;;
  server)
    exec chronyd -x -U -d -f /etc/chrony/chrony-server.conf
    ;;
  *)
    echo "Unknown command: ${1}"
    exit 1
    ;;
esac
