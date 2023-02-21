#!/bin/bash

set -e
apt-get update

# Add nodejs 16 repository
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 

nvm install 18.10.0

nvm use 18.10.0

apt-get update && apt-get -y install gcc g++ make yarn
# clean apt to reduce image size
rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/apt
