#!/bin/sh

# Clean up
sudo docker network rm "webapp_net" "internal_net" "dmz_net"

# Create networks
sudo ip link set ens19 up
sudo docker network create -d macvlan --subnet=10.0.3.0/24 --gateway=10.0.3.1 -o parent=ens19.3 webapp_net
sudo docker network create -d macvlan --subnet=10.0.2.0/24 --gateway=10.0.2.1 -o parent=ens19.2 internal_net
sudo docker network create -d macvlan --subnet=10.0.1.0/24 --gateway=10.0.1.1 -o parent=ens19.1 dmz_net


