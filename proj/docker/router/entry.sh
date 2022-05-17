#!/bin/sh

dflt_gateway="$1"

ip r del default
ip r add default via "$dflt_gateway"

tail -f "/dev/null"
