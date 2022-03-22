# Passing Private key to VM-A
scp ./ssh/keys/privBC.rsa vma:~/.ssh/

# Passing VM-B/C config file to VM-A
scp ./ssh/configA.ssh vma:~/.ssh/

# Copying files to VM-B
scp -r client/ vmb:~
scp -r router/ vmb:~
scp -r server/ vmb:~
scp runDockers.sh vmb:~

# Config NAT

# # Config VM-A
ssh -t vma 'sudo ip a a 192.168.88.100/24 dev ens19; sudo ip link set ens19 up'
ssh -t vma 'sudo sysctl -w net.ipv4.ip_forward=1 && sudo iptables -t nat -A POSTROUTING -s 192.168.88.101 -o eth0 -j MASQUERADE'

# Config VM-B
ssh -t vmb 'sudo ip route del default; sudo ip r a default via 192.168.88.100'
ssh -t vmb 'sudo sed -i "s/nameserver 127.0.0.53/nameserver 8.8.8.8/g" /etc/resolv.conf'

# Install docker
ssh -t vmb 'sudo apt-get update'
ssh -t vmb 'sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common'
ssh -t vmb 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -'
ssh -t vmb 'sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"'
ssh -t vmb 'sudo apt-get update'
ssh -t vmb 'sudo apt-get install -y docker-ce docker-ce-cli containerd.io'
ssh -t vmb 'sudo apt-get install -y docker-compose'

ssh -t vmb 'sudo usermod -G docker -a theuser'
ssh -t vmb 'sudo systemctl enable docker.service; sudo systemctl start docker.service'
ssh -t vmb 'sudo systemctl enable containerd.service; sudo systemctl start containerd.service'

ssh -t vmb 'sh runDockers.sh'

# Config VM-C
ssh -t vmc 'sudo ip link set ens19 up'
ssh -t vmc 'sudo ip a a 10.0.1.200/24 dev ens19'
ssh -t vmc 'sudo ip r a 10.0.2.0/24 via 10.0.1.254'