#!/bin/python3

import json
from sys import argv

architecture_file = argv[1]
compose_file = argv[2]

with open(architecture_file) as f:
    net_arch = json.load(f)

with open(compose_file) as f:
    template = f.read()

# we do 2 file paths, so chain substituion works, e.g.:
#   - entrypoints using network entries
#   - entries using information from other entries
for i in range(2):
    for container in net_arch:
        container_name = container["name"]

        for node_name, node in container.items():
            if node_name == "networks":
                for network in node:
                    ip = network["ip"]
                    name = network["name"]
                    template = template.replace(f"{container_name}_{name}", ip)
            elif node_name == "entrypoints":
                entrypoint_args = []
                for entrypoint in node:
                    if "commands" in entrypoint:
                        cmd = f"{entrypoint['path']} {' '.join(entrypoint['commands'])}"
                    else:
                        cmd = entrypoint["path"]
                    entrypoint_args.append(cmd)

                entrypoint_cmd = "/bin/sh -c '" + (" && ".join(entrypoint_args)) + "'"
                template = template.replace(f"{container_name}_entrypoint", entrypoint_cmd)
            elif node_name != "name":
                # fill other (container-specific) properties
                template = template.replace(f"{container_name}_{node_name}", node)

print(template, end="")
