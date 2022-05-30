#!/bin/python3

import json
import subprocess
import sys

architecture_file = sys.argv[1]
compose_file = sys.argv[2]
f = open(architecture_file)
net_arch = json.load(f)

sed_expressions = []
for container in net_arch:
    container_name = container["name"]

    for node in container:
        if node == "networks":
            for network in container["networks"]:
                ip = network["ip"]
                name = network["name"]
                sed_expressions.extend(["-e", f"s|{container_name}_{name}|{ip}|ig"])
        elif node == "entrypoints":
            entrypoints_len = (
                len(container["entrypoints"]) if "entrypoints" in container else 0
            )
            if entrypoints_len:
                entrypoint_cmd = "/bin/sh -c '"
                entrypoint_args = []
                for i in range(entrypoints_len):
                    entrypoint = container["entrypoints"][i]
                    entrypoint_args.append(
                        "{path} {arguments}".format(
                            path=entrypoint["path"],
                            arguments=" ".join(entrypoint["commands"]),
                        )
                        if "commands" in entrypoint
                        else "{path}".format(path=entrypoint["path"])
                    )

                entrypoint_cmd += r" \&\& ".join(entrypoint_args) + "'"
                sed_expressions.extend(
                    ["-e", f"s|{container_name}_entrypoint|{entrypoint_cmd}|ig"]
                )
        elif node != "name":  # Fill other params of container
            val = container[node]
            sed_expressions.extend(["-e", f's|{container_name}_{node}|"{val}"|ig'])


f.close()
subprocess.call(["sed", *sed_expressions, compose_file])
