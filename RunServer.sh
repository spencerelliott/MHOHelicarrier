#!/bin/bash

CWD=`pwd`

# Uncomment this line if your Steam Deck is throwing an error about ports
# sudo sysctl net.ipv4.ip_unprivileged_port_start=80

podman run -ti --hostname mho -p 80:80 -p 443:443 -p 4306:4306 -v ${CWD}/player_data:/mho/player_data mho

