#!/bin/bash

CWD=`pwd`

podman run -ti --hostname mho -p 80:80 -p 443:443 -p 4306:4306 -v ${CWD}/player_data:/mho/player_data mho

