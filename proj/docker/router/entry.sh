#!/bin/bash

ip r del default via "$1"
ip r add default via "$1"


tail -f "/dev/null"
