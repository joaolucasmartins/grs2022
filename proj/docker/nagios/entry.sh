#!/bin/bash

dflt_gateway="$1"

ip r d default
ip r a default via "$dflt_gateway"

/usr/local/bin/start_nagios