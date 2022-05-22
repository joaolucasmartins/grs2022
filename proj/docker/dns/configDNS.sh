#!/bin/bash

ip_network="$1"
ip_gateway="$2"

ip r add "$ip_network" via "$ip_gateway"

/usr/sbin/named -g -c /etc/bind/named.conf -u bind