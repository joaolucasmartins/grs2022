#!/bin/sh

# Clean up
echo "Clean up"
sudo systemctl stop docker-compose@lisboa

# Deploy containers
echo "Deploy containers"
sudo ip link set ens19 up
sudo systemctl start docker-compose@lisboa

echo "Test (curl the webapp proxy)"
sudo docker exec "r_b" curl 10.0.1.5
