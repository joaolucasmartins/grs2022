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

printf "\t1. curl the webapp proxy"
sudo docker exec "r_b" curl 10.0.1.5 2>/dev/null

printf "\t2. webdevs getting leases from DHCP server"
sudo docker exec "webdev1" /bin/sh -c "dhcpcd -t 15 2>&1 | grep '.* leased .* for .* seconds'"
sudo docker exec "webdev2" /bin/sh -c "dhcpcd -t 15 2>&1 | grep '.* leased .* for .* seconds'"

printf "\t3. access to pgadmin"
sudo docker exec "webdev1" curl 10.0.2.3 2>/dev/null
