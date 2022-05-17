#!/bin/sh

# Clean up
echo "Clean up"
sudo systemctl stop docker-compose@lisboa

# Create networks
echo "Creating networks"
sudo ip link set ens19 up

# Deploy containers
echo "Deploy containers"
sudo systemctl start docker-compose@lisboa

echo "Test (curl the webapp proxy)"
sudo docker exec "r_b" curl 10.0.1.5
