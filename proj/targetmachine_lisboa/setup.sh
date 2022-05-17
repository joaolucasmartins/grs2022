#!/bin/sh

# Clean up
echo "Clean up"
sudo docker rm -f "r1" "webapp" "webapp_worker1" "webapp_worker2"
sudo docker network rm "webapp_net" "internal_net" "dmz_net"

# Create networks
echo "Creating networks"
sudo ip link set ens19 up

# Deploy router
echo "Deploying router"
sudo docker run -d --name "r1" router 
sudo systemctl start docker-compose@lisboa

# Server and workers
echo "Deploying workers"
sudo docker run -d --net webapp_net --ip 10.0.3.2 --cap-add=NET_ADMIN --name webapp_worker1 webapp_worker
sudo docker run -d --net webapp_net --ip 10.0.3.3 --cap-add=NET_ADMIN --name webapp_worker2 webapp_worker
echo "Deploying server"
sudo docker run -d --net webapp_net --ip 10.0.3.1 --cap-add=NET_ADMIN --name webapp webapp

# Connect webapp to networks
echo "Connecting webapp to DMZ network"
sudo docker network connect "dmz_net" webapp --ip "10.0.1.5"
echo "Setting webapp routes"
sudo docker exec webapp /bin/bash -c 'ip r del default via 10.0.1.254'
sudo docker exec webapp /bin/bash -c 'ip r a 10.0.2.0/24 via 10.0.1.2' 

echo "Test"
sudo docker exec r1 curl 10.0.1.5
