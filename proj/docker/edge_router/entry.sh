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
iptables -t nat -A POSTROUTING -o eth2 -j MASQUERADE
iptables -P FORWARD DROP
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m state --state NEW -i eth0 -j ACCEPT
iptables -A FORWARD -m state --state NEW -i eth2 -d "$dmz_ip" -j ACCEPT

# Port forwarding webapp
iptables -A PREROUTING -t nat -i eth1 -p tcp --dport 80 -j DNAT --to 10.0.1.5:80
iptables -A FORWARD -p tcp -d 10.0.1.5 --dport 80 -j ACCEPT
iptables -A PREROUTING -t nat -i eth1 -p tcp --dport 80 -j DNAT --to 10.0.1.5:443
iptables -A FORWARD -p tcp -d 10.0.1.5 --dport 443 -j ACCEPT

iptables -A PREROUTING -t nat -i eth2 -p tcp --dport 80 -j DNAT --to 10.0.1.5:80
iptables -A FORWARD -p tcp -d 10.0.1.5 --dport 80 -j ACCEPT
iptables -A PREROUTING -t nat -i eth2 -p tcp --dport 80 -j DNAT --to 10.0.1.5:443
iptables -A FORWARD -p tcp -d 10.0.1.5 --dport 443 -j ACCEPT

tail -f "/dev/null"
