#!/bin/bash

iptables -t nat -F
iptables -t filter -F
iptables -t nat -A POSTROUTING -j MASQUERADE
