#!/bin/bash

service nagios-nrpe-server start
nginx -g 'daemon off;'