#!/bin/sh

test_cmd() {
  $@
  [ $? -eq 0 ] && printf "\033[01;32m%s\033[00m\n" "SUCCESS" || printf "\033[01;31m%s\033[00m\n" "FAILURE"
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

printf "1. curl the webapp proxy\n"
test_cmd sudo docker exec "r_b" curl 10.0.1.5 2>/dev/null
echo

printf "2. webdevs getting leases from DHCP server\n"
echo "Sleeping for 15 seconds, so the addresses have time to be acquired..."
sleep 15
echo "Webdev 1 DHCP"
test_cmd sudo docker exec "webdev1" /bin/sh -c "ip a | grep global | awk '{print \$2}'"
echo "Webdev 2 DHCP"
test_cmd sudo docker exec "webdev2" /bin/sh -c "ip a | grep global | awk '{print \$2}'"
echo

printf "3. access to webdev pgadmin\n"
test_cmd sudo docker exec "webdev1" w3m 10.0.2.3
echo

printf "4. webdev access webapp (only works if DHCP test works)\n"
test_cmd sudo docker exec "webdev2" w3m 10.0.1.5
echo

printf "5. webdev access the internet\n"
test_cmd sudo docker exec "webdev1" w3m example.com

printf "6. external host access webapp\n"
test_cmd sudo docker exec "external_host_b" ping -c 3 10.0.1.5
