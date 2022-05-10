# Bancada 5 

- **Proxmox PVE**
**IP**: https://192.168.109.121:8006 \
**User**: gors-students \
**Password**: worVWggpbTo4 \
**Realm**: PVE authentication 

- **VMs**: *vm-A-705*, *vm-BC-809*, *vm-BC-810*

**Management IP (VM-A):** 192.168.109.155

**Acessing VM-A (192.168.109.155)**: 
`ssh -i vma.rsa theuser@192.168.109.155`

*Or*

`ssh vma`

**Copying public/private keys and configs to VM-A:**

`scp ~/.ssh/vmb_c/privBC.rsa vma:~/.ssh/`

`scp ~/.ssh/vmb_c/config vma:~/.ssh/`

## **FROM Local machine => SSH VM-A (~/.ssh/config):**
- `ssh vma` | `ssh vmb`

*Config (Host):*

```
Host vma
  HostName 192.168.109.155
  IdentityFile ~/.ssh/keys/privA.rsa
  IdentitiesOnly yes
  User theuser

Host vmb
  HostName 192.168.88.101
  IdentityFile ~/.ssh/keys/privBC.rsa
  IdentitiesOnly yes 
  User theuser
  ProxyJump vma
```

## **FROM Local machine => SSH VM-B/C (~/.ssh/config):**
- `ssh vmb` | `ssh vmc`

*Config (VM-B):*

```
Host vmb
  HostName 192.168.88.101
  IdentityFile ~/.ssh/privBC.rsa
  IdentitiesOnly yes
  User theuser

Host vmc
  Hostname 192.168.88.102
  IdentityFile ~/.ssh/privBC.rsa
  IdentitiesOnly yes
  User theuser
```

## Connecting VM-B to the internet.
- **VM-A:** \
`sysctl -w net.ipv4.ip_forward=1` \
`iptables -t nat -A POSTROUTING -s 192.168.88.101 -o eth0 -j MASQUERADE`

- **VM-B:** \
`ip r a default via 192.168.88.100` 

*(might need to delete already pre-defined default gateway `sudo ip route show` | `sudo ip route del default`)*

Afterwards, install docker by following the steps in this [guide](https://gist.github.com/rmorla/61098bf2fc333a8c090db3e5bc77394b).

### Instructions for when you Nuke the VMs

- **VM-A**
  - Proxmox **>** Hardware **>** Add Network **>** vmbr0 and vmbr4
  - `sudo ip a a 192.168.88.100/24 dev ens19`
  - `sudo ip link set ens19 up`

- **VM-B**
  - Proxmox **>** Hardware **>** Add Network **>** vmbr4, vmbr1 and vmbr2

- **VM-C**
  - Proxmox **>** Hardware **>** Add Network **>** vmbr1, vmbr4

### Acessing Mikrotik router
- User: admin
- Password: [blank] 

### Port Forwarding to access switch
- LocalForward (SSH config file)
- `ssh -L 8888:192.168.88.1:80 vma` (Acessing port 80 on switch through VM-A)

## VM-B
- Set Interfaces UP (ens19 & ens20)
- `sudo ip link set ens19`
- `sudo ip link set ens20`
- `sudo ip a a 10.0.1.99/24 dev ens19`

## VM-C
- Set Interfaces UP (ens19)
- `sudo ip link set ens19`
- `sudo ip r a 10.0.2.0/24 via 10.0.1.254`

# Monitoring

## Start Nagios Server

- Build Nagios image
  - `docker build -t nagios-c .`
- Run Nagios in **VM-B**
  - `docker run --name nagios -d --net server_net --ip 10.0.2.99 -p 0.0.0.0:8080:80 nagios-c # VM-B`
- Run Nagios in **VM-C**
  - `docker run --name nagios -d -p 0.0.0.0:8080:80 nagios-c # VM-C`

## Logs

### **Nagios**
Inside VM-C, using the command `sudo tcpdump -i ens19 -w nagios.pcap`, we were able to capture the traffic generated from Nagios. It's a active measurement, of course, as there's packet injection inside the network.

After that, download the file to the host machine using the command `scp vmc:~/nagios.pcap nagios.pcap`.
Opening this file with wireshark will first show an active measurement for the Nagios' `check_load` command. The entire connection is encrypted. In between, there are also some ARP requests, probably to refresh the cache. We also see a bunch if `pings`. This is so that Nagios can know if `10.0.2.100` is UP/DOWN. Finally, the last TCP stream concerns the `check_http` command.

# DHCP
- Build DHCP Server image:
  - `docker build -t dhcp-image .`
- Run DHCP Server container:
  - `docker run -d --rm --net client_net --ip 10.0.1.2 --name dhcp-server --cap-add=NET_ADMIN -v $(pwd)/dhcp.conf:/etc/dhcp/dhcpd.conf dhcp-image`