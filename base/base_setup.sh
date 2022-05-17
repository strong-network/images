#!/usr/bin/env sh
apt-get update && apt-get install -y build-essential clang-format clang curl git-lfs git htop less libffi-dev libkrb5-dev libssl-dev locales man nano procps python3-dev python3-pip python3-venv ssh sudo tmux vim wget zsh
# Set default shell
chsh -s /bin/bash
# https://wiki.debian.org/Locale#Manually
sed -i 's/# en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && locale-gen
# Unpack fixuid
wget https://github.com/boxboat/fixuid/releases/download/v0.5.1/fixuid-0.5.1-linux-amd64.tar.gz -O fixuid-linux-amd64.tar.gz
tar -C /usr/bin -xzf fixuid-linux-amd64.tar.gz
rm fixuid-linux-amd64.tar.gz
# Install docker
wget https://download.docker.com/linux/static/stable/x86_64/docker-20.10.12.tgz -O  docker.tar.gz
tar -C /tmp -xzf docker.tar.gz
rm docker.tar.gz
mv /tmp/docker/docker /usr/bin/
mv /tmp/docker/dockerd /usr/bin/
rm -r /tmp/docker
wget https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-linux-x86_64 -O /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
# Create startup directory
mkdir -p /usr/bin/strong_network_startup
# Set permisions
chown root:root /usr/bin/fixuid
chmod 4755 /usr/bin/fixuid
mkdir -p /etc/fixuid
printf 'user: developer\ngroup: developer\n' > /etc/fixuid/config.yml
adduser --gecos '' --disabled-password developer
echo 'developer ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/nopasswd
# Change permissions of /usr/local
chgrp -R developer /usr/local
chmod -R g+w /usr/local