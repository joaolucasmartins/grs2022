#!/bin/sh

old_dflt_gateway="$1"
new_dflt_gateway="$2"

ip r del default via "$old_dflt_gateway"
ip r add default via "$new_dflt_gateway"

/usr/sbin/nginx -g "daemon off;"
