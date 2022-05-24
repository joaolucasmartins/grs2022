#!/bin/sh

dflt_gateway="$1"

ip r del default
ip r add default via "$dflt_gateway"

# drop DHCP requests that attempt to leave the local network
#iptables -A INPUT -p udp --dport 67:68 -j DROP
#iptables -A INPUT -p tcp --dport 67:68 -j DROP
#iptables -A FORWARD -p udp --dport 67:68 -j DROP
#iptables -A FORWARD -p tcp --dport 67:68 -j DROP
#iptables -A OUTPUT -p udp --dport 67:68 -j DROP
#iptables -A OUTPUT -p tcp --dport 67:68 -j DROP

tail -f "/dev/null"
