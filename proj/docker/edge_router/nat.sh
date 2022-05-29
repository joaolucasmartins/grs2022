#!/bin/bash

iptables -t nat -F
iptables -t filter -F
iptables -t nat -A POSTROUTING -j MASQUERADE

iptables -A INPUT -p udp -m udp --dport 67:68 -j DROP
