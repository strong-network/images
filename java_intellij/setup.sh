#!/usr/bin/env sh

# Set the ide.tar.gz file
wget -O /ide.tar.gz https://download-cf.jetbrains.com/idea/ideaIC-2021.3.2.tar.gz
/unzip_ide.sh

sudo rm -rf /var/lib/apt/lists/*
sudo rm -rf /var/cache/apt

chown -R developer:developer /ide/bin