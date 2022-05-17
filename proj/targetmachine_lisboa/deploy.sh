#!/bin/sh

# Clean up
echo "Clean up"
sudo systemctl stop docker-compose@lisboa

# Deploy containers
echo "Deploy containers"
sudo ip link set ens19 up
sudo systemctl start docker-compose@lisboa

# Tests
echo "Run tests:"

printf "1. curl the webapp proxy\n"
sudo docker exec "r_b" curl 10.0.1.5 2>/dev/null
echo

printf "2. webdevs getting leases from DHCP server\n"
echo "Sleeping for 10 seconds, so the addresses have time to be acquired..."
sleep 10
echo "Webdev 1 DHCP"
sudo docker exec "webdev1" /bin/sh -c "ip a | grep global | awk '{print \$2}'"
echo "Webdev 2 DHCP"
sudo docker exec "webdev2" /bin/sh -c "ip a | grep global | awk '{print \$2}'"
echo

printf "3. access to webdev pgadmin\n"
sudo docker exec "webdev1" curl 10.0.2.3 2>/dev/null
