#!/bin/sh

set -e

# Clean up
echo "Clean up"
if ! sudo systemctl stop docker-compose@lisboa; then
  sudo systemctl status docker-compose@lisboa
  exit 1
fi

# Deploy containers
echo "Deploy containers"
sudo ip link set ens19 up
sudo ip link set ens20 up
if ! sudo systemctl start docker-compose@lisboa; then
  sudo systemctl status docker-compose@lisboa
  exit 1
fi
