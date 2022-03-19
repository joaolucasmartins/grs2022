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
  - `sudo ip a a 192.168.88.100/24 dev ens19`
  - `sudo ip link set ens19 up`
  - `sudo ip link set ens20 up`
  - Proxmox **>** Hardware **>** Add Network **>** vmbr0 and vmbr4

- **VM-B**
  - Proxmox **>** Hardware **>** Add Network **>** vmbr4
