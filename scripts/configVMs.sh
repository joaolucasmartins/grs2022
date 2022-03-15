# Passing Private key to VM-A
scp ~/.ssh/keys/privBC.rsa vma:~/.ssh/

# Passing VM-B/C config file to VM-A
scp ~/.ssh/configA.ssh vma:~/.ssh/

# Copying files to VM-B
scp -r client/ vmb:~
scp -r router/ vmb:~
scp -r server/ vmb:~

# Config VM-A
ssh -t vma 'sudo sysctl -w net.ipv4.ip_forward=1 && sudo iptables -t nat -A POSTROUTING -s 192.168.88.101 -o eth0 -j MASQUERADE'

# Config VM-B
ssh -t vmb 'sudo ip route del default && sudo ip r a default via 192.168.88.100'