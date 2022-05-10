#!/bin/python3

from netmiko import ConnectHandler, file_transfer
from netmiko import SCPConn

pc_num = 5 # Our PC is 5

device_A = {
    'device_type': 'linux',
    'ip': f"192.168.109.15{pc_num}", 
    'username': 'theuser',
    'use_keys': True,
    'key_file': './ssh/keys/privA.rsa'
}

def sendFiles(ssh_con, files):
    scp_conn = SCPConn(ssh_con)
    for (source, dest) in files:
        scp_conn.scp_transfer_file(source, dest)
    scp_conn.close()

def initConfig():
    ssh_A = ConnectHandler(**device_A)
    ssh_A.enable()

    # Send B and C keys to A
    sendBCKey = ("ssh/keys/privBC.rsa", ".ssh/")
    sendAConfig = ("ssh/configA.ssh", ".ssh/config")
    sendFiles(ssh_A, [sendBCKey, sendAConfig])

    ssh_A.disconnect()

initConfig()
