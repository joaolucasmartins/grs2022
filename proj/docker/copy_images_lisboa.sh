#!/bin/sh

# Copy images to vmb
scp -r router vmb:~
scp -r webapp vmb:~
scp -r webapp_worker vmb:~