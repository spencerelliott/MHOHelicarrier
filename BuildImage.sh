#!/bin/bash

# Default to Crypto's git repo
GIT_URL=https://github.com/Crypto137/MHServerEmu.git

# Comment out the above and uncomment this line to use Alex Bond's git repo
# GIT_URL=https://github.com/AlexBond2/MHServerEmu.git

# Default to nighly branch. Switch to "stable" if the stable branch is desired.
BRANCH=master

if ! [ -f data/mu_cdata.sip ] || ! [ -f data/Calligraphy.sip ]; then
    echo "You must provide mu_cdata.sip and Calligraphy.sip before building the image"
    exit 1
fi

podman build --build-arg CACHEBUST=$(date +%s) --env SERVER_BRANCH=${BRANCH} --env GIT_URL=${GIT_URL} --tag mho .
yes | podman image prune

