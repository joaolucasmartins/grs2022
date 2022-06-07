#!/bin/sh

ip r d default
ip r a default via "$1"
