#!/bin/sh

test_cmd() {
  "$@" && printf "\033[01;32m%s\033[00m\n" "SUCCESS" || printf "\033[01;31m%s\033[00m\n" "FAILURE"
  echo
  echo "--------------------------------------------------------------------------------------------------------------------"
  echo
}

# Clean up
echo "Clean up"
sudo systemctl stop docker-compose@lisboa

# Deploy containers
echo "Deploy containers"
sudo ip link set ens19 up
sudo systemctl start docker-compose@lisboa

# Tests
echo "Run tests:"

