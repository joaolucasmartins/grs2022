#!/bin/sh

# Port forwarding webapp
iptables -A PREROUTING -t nat -i eth1 -p tcp --dport 80 -j DNAT --to 10.0.1.5:80
iptables -A FORWARD -p tcp -d 10.0.1.5 --dport 80 -j ACCEPT
iptables -A PREROUTING -t nat -i eth1 -p tcp --dport 80 -j DNAT --to 10.0.1.5:443
iptables -A FORWARD -p tcp -d 10.0.1.5 --dport 443 -j ACCEPT