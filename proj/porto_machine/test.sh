#!/bin/sh

set -e

test_cmd() {
  "$@" && printf "\033[01;32m%s\033[00m\n" "SUCCESS" || printf "\033[01;31m%s\033[00m\n" "FAILURE"
  echo
  echo "--------------------------------------------------------------------------------------------------------------------"
  echo
}

# Tests
echo "Run tests:"
echo "Sleeping for 15 seconds, so the addresses have time to be acquired..."
sleep 15

echo "1. curl the webapp from netmanager"
test_cmd sudo docker exec "netmanager1" curl myorg.net 2>/dev/null

echo "2. netmanager acess to internet"
test_cmd sudo docker exec "netmanager1" curl example.com 2>/dev/null

echo "3. Nagios check_nrpe (webapp)"
test_cmd sudo docker exec "nagios" /opt/nagios/libexec/check_nrpe -H 172.0.1.5 2>/dev/null

echo "4. Nagios check_http (webapp)"
test_cmd sudo docker exec "nagios" /opt/nagios/libexec/check_http -I 172.0.1.5 2>/dev/null

echo "5. Nagios interface"
test_cmd sudo docker exec "netmanager1" curl 10.1.2.3 -u nagiosadmin:nagios 2>/dev/null

echo "9. webdev dns to webapp"
test_cmd [ $(sudo docker exec "netmanager1" dig myorg.net +short) = "172.0.1.5" ]
