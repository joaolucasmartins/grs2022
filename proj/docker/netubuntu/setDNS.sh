#!/bin/bash

dns_server="$1"

# Set DNS server
printf "nameserver $dns_server\nnameserver 8.8.8.8" > /etc/resolv.conf