#!/bin/sh

ssh vmc 'bash -s' < ../helper_scripts/targetmachine_network.sh
ssh vmc 'bash -s' < ../helper_scripts/installdocker.sh
