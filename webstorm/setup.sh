#!/usr/bin/env sh

set -e
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

wget -O /ide.tar.gz https://download.jetbrains.com/webstorm/WebStorm-2022.2.3.tar.gz
/unzip_ide.sh

# Add nodejs 18 repository
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 

nvm install 18.10.0

nvm use 18.10.0
apt-get update && apt-get -y install gcc g++ make yarn dotnet-sdk-7.0

DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get install php libapache2-mod-php -y

# clean apt to reduce image size
sudo rm -rf /var/lib/apt/lists/*
sudo rm -rf /var/cache/apt

# change permissions
chown -R developer:developer /ide/bin