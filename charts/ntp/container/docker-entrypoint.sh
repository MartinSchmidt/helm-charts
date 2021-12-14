#!/bin/bash
set -o errexit

case "${1}" in
  client)
    if [ -z "$INTERNAL_NTP_SERVER" ] || [ -z "$INTERNAL_NTP_SERVERS" ]; then
      echo "Please set \$INTERNAL_NTP_SERVER and \$INTERNAL_NTP_SERVERS"
      exit 1
    fi
    sed -e "s/{{INTERNAL_NTP_SERVER}}/$INTERNAL_NTP_SERVER/" -e "s/{{INTERNAL_NTP_SERVERS}}/$INTERNAL_NTP_SERVERS/" -i /etc/chrony/chrony-client.conf
    exec chronyd -U -d -f /etc/chrony/chrony-client.conf
    ;;
  server)
    NTP_SERVER="${NTP_SERVER:-pool.ntp.org}"
    sed -e "s/{{NTP_SERVER}}/$NTP_SERVER/" -e "s/{{INTERNAL_NTP_SERVER}}/$INTERNAL_NTP_SERVER/" -e "s/{{INTERNAL_NTP_SERVERS}}/$INTERNAL_NTP_SERVERS/" -i /etc/chrony/chrony-server.conf
    exec chronyd -x -U -d -f /etc/chrony/chrony-server.conf
    ;;
  *)
    echo "Unknown command: ${1}"
    exit 1
    ;;
esac
