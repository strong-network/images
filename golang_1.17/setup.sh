#!/usr/bin/env sh
wget -O golang_sdk-linux-amd64.tar.gz https://golang.org/dl/go1.17.linux-amd64.tar.gz
tar -C /usr/local -xzf golang_sdk-linux-amd64.tar.gz
rm golang_sdk-linux-amd64.tar.gz
mv install_go_tools.sh /usr/bin/strong_network_startup/install_go_tools.sh 
chmod 4755 /usr/bin/strong_network_startup/install_go_tools.sh