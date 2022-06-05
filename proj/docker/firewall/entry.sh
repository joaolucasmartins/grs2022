#!/bin/sh

dflt_gateway="$1"
internal_gateway="$2"
dmz_ip="$3"
internal_network="$4"

ip r del default
ip r add default via "$dflt_gateway"

ip r add "$internal_network" via "$internal_gateway"

iptables -t nat -F
iptables -P FORWARD DROP
iptables -A FORWARD -m conntrack --ctstate NEW,ESTABLISHED,RELATED -d "$dmz_ip" -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -d "$internal_network" -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate NEW,ESTABLISHED,RELATED -s "$dmz_ip","$internal_network" -j ACCEPT
iptables -A FORWARD -s "$dmz_ip","$internal_network" -j ACCEPT

tail -f "/dev/null"
