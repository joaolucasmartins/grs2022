#!/bin/bash

dns_server="$1"

# Set DNS server
echo "nameserver $dns_server" > /etc/resolv.conf