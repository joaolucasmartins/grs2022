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

echo "1. curl the webapp proxy"
test_cmd sudo docker exec "r_b" curl 10.0.1.5 2>/dev/null

echo "2. webdevs getting leases from DHCP server"
echo "Sleeping for 15 seconds, so the addresses have time to be acquired..."
sleep 15
echo "Webdev 1 DHCP"
test_cmd sudo docker exec "webdev1" /bin/sh -c "ip a | grep global | awk '{print \$2}'"
echo "Webdev 2 DHCP"
test_cmd sudo docker exec "webdev2" /bin/sh -c "ip a | grep global | awk '{print \$2}'"

echo "3. access to webdev pgadmin"
test_cmd sudo docker exec "webdev1" curl 10.0.2.3 2>/dev/null

echo "4. webdev access webapp (only works if DHCP test works)"
test_cmd sudo docker exec "webdev2" curl 10.0.1.5 2>/dev/null

echo "5. webdev access the internet"
test_cmd sudo docker exec "webdev1" curl example.com

echo "6. external host access webapp"
test_cmd sudo docker exec "external_host_b" curl 172.31.255.253 2>/dev/null

