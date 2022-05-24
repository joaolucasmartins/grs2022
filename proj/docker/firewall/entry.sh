#!/bin/sh

ip r del default
ip r add default via 10.1.1.1

ip r add 10.1.2.0/24 via 10.1.1.2

iptables -t nat -F
iptables -t nat -A POSTROUTING -j SNAT --to-source 10.1.1.3
iptables -P FORWARD DROP
iptables -A FORWARD -m state --state NEW,ESTABLISHED,RELATED -d 10.1.1.0/24 -j ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -d 10.1.2.0/24 -j ACCEPT
iptables -A FORWARD -m state --state NEW,ESTABLISHED,RELATED -s 10.1.1.0/24,10.1.2.0/24 -j ACCEPT

tail -f "/dev/null"
