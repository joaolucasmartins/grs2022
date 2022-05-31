#!/bin/sh

test_cmd() {
  "$@" && printf "\033[01;32m%s\033[00m\n" "SUCCESS" || printf "\033[01;31m%s\033[00m\n" "FAILURE"
  echo
  echo "--------------------------------------------------------------------------------------------------------------------"
  echo
}

# Clean up
echo "Clean up"
sudo systemctl stop docker-compose@porto

# Deploy containers
echo "Deploy containers"
sudo ip link set ens19 up
sudo ip link set ens20 up
sudo systemctl start docker-compose@porto

# Tests
echo "Run tests:"
echo "Sleeping for 15 seconds, so the addresses have time to be acquired..."
sleep 15

echo "1. curl the webapp from netmanager"
echo "Sleeping for 15 secs waiting for DHCP to attribute an IP"
sleep 15
test_cmd sudo docker exec "netmanager1" curl myorg.net 2>/dev/null

echo "2. netmanager acess to internet"
test_cmd sudo docker exec "netmanager1" curl example.com 2>/dev/null

# DNS Tests here
