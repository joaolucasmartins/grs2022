#!/bin/sh

dflt_gateway="$1"
dmz_ip="$2"
internal_network="$3"
internal_gateway="$4"

ip r del default
ip r add default via "$dflt_gateway"

ip r add "$internal_network" via "$internal_gateway"

iptables -t nat -F
iptables -t filter -F
iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
iptables -P FORWARD DROP
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m state --state NEW -i eth0 -j ACCEPT
iptables -A FORWARD -m state --state NEW -i eth1 -d "$dmz_ip" -j ACCEPT

tail -f "/dev/null"
