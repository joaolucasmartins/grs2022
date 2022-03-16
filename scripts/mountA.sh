#!/bin/sh
pc=5

mkdir vmb
sshfs theuser@vmb:/home/theuser vmb -o IdentityFile=~/.ssh/grs.rsa
