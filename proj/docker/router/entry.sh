#!/bin/sh

dflt_gateway="$1"

ip r del default
ip r add default via "$dflt_gateway"

# drop DHCp requests that attempt to leave the local network
iptables -A FORWARD -p udp --dport 67 -j DROP
iptables -A FORWARD -p udp --sport 68 -j DROP

tail -f "/dev/null"
