# Passing Private key to VM-A
scp ~/.ssh/keys/privBC.rsa vma:~/.ssh/

# Passing VM-B/C config file to VM-A
scp ~/.ssh/configA.ssh vma:~/.ssh/

# Copying files to VM-B
scp -r client/ vmb:~
scp -r router/ vmb:~
scp -r server/ vmb:~