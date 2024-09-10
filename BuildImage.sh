#!/bin/bash

# Default to nighly branch. Switch to "stable" if the stable branch is desired.
BRANCH=master

if ! [ -f data/mu_cdata.sip ] || ! [ -f data/Calligraphy.sip ]; then
    echo "You must provide mu_cdata.sip and Calligraphy.sip before building the image"
    exit 1
fi

podman build --build-arg CACHEBUST=$(date +%s) --env SERVER_BRANCH=${BRANCH} --tag mho .
yes | podman image prune

