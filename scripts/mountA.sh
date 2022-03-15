#!/bin/sh
pc=5

mkdir vma
sshfs theuser@192.168.109.15$pc:/home/theuser vma -o IdentityFile=~/.ssh/grs.rsa
