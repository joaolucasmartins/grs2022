#!/bin/sh

ssh vmc 'bash -s' < ../helper_scripts/targetmachine_network.sh
ssh vmc 'bash -s' < ../helper_scripts/installdocker.sh
ssh vmc 'bash -s' < ./config_c.sh
python3 network_conf.py netarchitecture.json docker-compose.yml | ssh vmc 'tee docker-compose.yml' > /dev/null

scp -r ../switch/switch_bridges.ssh switch-ssh:/scripts.to.run
ssh switch-ssh '/import /scripts.to.run'
