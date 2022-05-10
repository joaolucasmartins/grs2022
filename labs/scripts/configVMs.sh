#!/bin/bash

# Passing Private key to VM-A
scp ./ssh/keys/privBC.rsa vma:~/.ssh/

# Passing VM-B/C config file to VM-A
scp ./ssh/configA.ssh vma:~/.ssh/

# Passing confs. to VM-A
scp confA.sh vma:~

# Copying files to VM-B
scp -r client/ vmb:~
scp -r router/ vmb:~
scp -r server/ vmb:~
scp -r dhcp-server/ vmb:~
scp -r proxy/ vmb:~
scp -r netubuntu/ vmb:~
scp confB.sh vmb:~

# Passing confs. to VM-C
scp confC.sh vmc:~
scp -r nagios/ vmc:~

# Config VM-A
ssh -t vma 'sh confA.sh'

# Config VM-B
ssh -t vmb 'sh confB.sh'

# Config VM-C
ssh -t vmc 'sh confC.sh'