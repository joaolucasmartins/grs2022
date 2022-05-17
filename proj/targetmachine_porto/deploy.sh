#!/bin/sh

# TODO Put this config file

# python3 network_conf.py netarchitecture.json docker-compose.yml | ssh vmc 'tee docker-compose.yml' > /dev/null

# Config switch
scp -r ../switch/switch_bridges.ssh switch-ssh:/scripts.to.run
ssh switch-ssh '/import /scripts.to.run'
