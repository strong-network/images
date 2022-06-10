#!/usr/bin/env sh


wget -O golang_sdk-linux-amd64.tar.gz https://golang.org/dl/go1.18.linux-amd64.tar.gz
tar -C /usr/local -xzf golang_sdk-linux-amd64.tar.gz
rm golang_sdk-linux-amd64.tar.gz
mv install_go_tools.sh /usr/bin/strong_network_startup/install_go_tools.sh
chmod 4755 /usr/bin/strong_network_startup/install_go_tools.sh
# Install vscode deps
bash install_nodejs_tools.sh && rm install_nodejs_tools.sh
apt-get update
DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get install -y libsecret-1-dev libx11-dev libxkbfile-dev gettext-base rsync unzip gcc g++ make nodejs yarn python2 openjdk-11-jdk
update-alternatives --install /usr/bin/python python /usr/bin/python2 1
update-alternatives --install /usr/bin/python python /usr/bin/python3 2
curl -fsSOL http://http.us.debian.org/debian/pool/main/libo/libonig/libonig5_6.9.1-1_amd64.deb
dpkg -i libonig*.deb
curl -fsSOL http://http.us.debian.org/debian/pool/main/j/jq/libjq1_1.5+dfsg-2+b1_amd64.deb
dpkg -i libjq*.deb
curl -fsSOL http://http.us.debian.org/debian/pool/main/j/jq/jq_1.5+dfsg-2+b1_amd64.deb
dpkg -i jq*.deb && rm *.deb
# Install deployment dependencies
wget -O doctl.tar.gz https://github.com/digitalocean/doctl/releases/download/v1.70.0/doctl-1.70.0-linux-amd64.tar.gz
tar -C /usr/local/bin -xzf doctl.tar.gz
rm doctl.tar.gz
wget -O helm.tar.gz https://get.helm.sh/helm-v3.8.0-linux-amd64.tar.gz
tar -C /tmp -xzf helm.tar.gz
mv /tmp/linux-amd64/helm /usr/local/bin
rm helm.tar.gz
rm -r /tmp/linux-amd64
wget -O kubectl https://storage.googleapis.com/kubernetes-release/release/v1.23.3/bin/linux/amd64/kubectl
mv kubectl /usr/local/bin
chmod 4755 /usr/local/bin/kubectl
# Install latest npm
npm install -g npm