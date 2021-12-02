#!/usr/bin/env bash

set -xeEo pipefail

#############
# VARIABLES #
#############
: "${BLOCK:=$(sudo lsblk --paths | awk '/14G/ {print $1}' | head -1)}"
NETWORK_ERROR="connection reset by peer"
SERVICE_UNAVAILABLE_ERROR="Service Unavailable"
INTERNAL_ERROR="INTERNAL_ERROR"
INTERNAL_SERVER_ERROR="500 Internal Server Error"

function use_local_disk() {
  BLOCK_DATA_PART=${BLOCK}1
  sudo dmsetup version || true
  sudo swapoff --all --verbose
  if mountpoint -q /mnt; then
    sudo umount /mnt
    # search for the device since it keeps changing between sda and sdb
    sudo wipefs --all --force "$BLOCK_DATA_PART"
  else
    # it's the hosted runner!
    sudo sgdisk --zap-all --clear --mbrtogpt -g -- "${BLOCK}"
    sudo dd if=/dev/zero of="${BLOCK}" bs=1M count=10 oflag=direct
    sudo parted -s "${BLOCK}" mklabel gpt
  fi
  sudo lsblk
}
