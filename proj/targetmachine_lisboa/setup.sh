#!/bin/sh

# Clean up
echo "Clean up"
sudo systemctl stop docker-compose@lisboa
#sudo docker rm -f "r1" "webapp" "webapp_worker1" "webapp_worker2"
#sudo docker network rm "webapp_net" "internal_net" "dmz_net"

# Create networks
echo "Creating networks"
sudo ip link set ens19 up

# Deploy router
echo "Deploying router"
sudo docker run -d --name "r1" router 
sudo systemctl start docker-compose@lisboa

echo "Test"
sudo docker exec r1 curl 10.0.1.5
