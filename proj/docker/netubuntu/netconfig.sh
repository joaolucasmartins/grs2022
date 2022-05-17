#!/bin/bash

ip_default_gateway="$1"
ip_new_default_gateway="$2"

ip r d default via "$ip_default_gateway"
ip r a default via "$ip_new_default_gateway"

/bin/sh -c "tail -f /dev/null"
