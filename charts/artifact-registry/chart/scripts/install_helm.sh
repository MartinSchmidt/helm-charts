#!/bin/bash
set -e

apt-get update && apt-get upgrade
apt-get install curl gnupg2 --yes
curl https://baltocdn.com/helm/signing.asc >> signing.asc
apt-key add signing.asc
apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" > /etc/apt/sources.list.d/helm-stable-debian.list
apt-get update
apt-get install helm
