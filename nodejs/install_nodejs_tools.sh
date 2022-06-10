#!/bin/bash

set -e
apt-get update

# Add nodejs 16 repository
curl -fsSL https://deb.nodesource.com/setup_16.x | bash -

curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

apt-get update && apt-get -y install gcc g++ make nodejs yarn
# clean apt to reduce image size
rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/apt
