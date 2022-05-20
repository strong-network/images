#!/usr/bin/env sh

wget -O /ide.tar.gz https://download-cf.jetbrains.com/webide/PhpStorm-2021.3.2.tar.gz
/unzip_ide.sh

DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get install php libapache2-mod-php -y

# clean apt to reduce image size
sudo rm -rf /var/lib/apt/lists/*
sudo rm -rf /var/cache/apt

# change permissions
chown -R developer:developer /ide/bin