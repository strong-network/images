FROM ubuntu:22.04

ENV SHELL=/bin/bash
ENV LANG=en_US.UTF-8
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Install base packages for other applications and update the package repository
RUN apt-get update ;\
    apt-get install -y git wget python3-dev python3-pip python3-venv curl libffi-dev libkrb5-dev libssl-dev build-essential clang-format clang ;\
    DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get -y install unzip openjdk-11-jdk libxext6 libxrender1 libxtst6 libxi6 libfreetype6 

# Download common developer tools and SDK as tarball
RUN wget https://download.docker.com/linux/static/stable/x86_64/docker-20.10.19.tgz -O  docker.tar.gz ;\
    tar -C /tmp -xzf docker.tar.gz ;\
    rm docker.tar.gz ;\
    mv /tmp/docker/docker /usr/bin/ ;\
    rm -r /tmp/docker ;\
    wget https://github.com/docker/compose/releases/download/v2.14.0/docker-compose-linux-x86_64 -O /usr/local/bin/docker-compose ;\
    chmod +x /usr/local/bin/docker-compose ;\
    mkdir -p /usr/bin/strong_network_startup ;\
    wget https://github.com/boxboat/fixuid/releases/download/v0.5.1/fixuid-0.5.1-linux-amd64.tar.gz -O fixuid-linux-amd64.tar.gz ;\
    tar -C /usr/bin -xzf fixuid-linux-amd64.tar.gz ;\
    rm fixuid-linux-amd64.tar.gz

# Setup environment for developers
    # install general packages related to development
RUN apt-get install -y  git-lfs git htop less locales man nano  ssh sudo tmux vim zsh software-properties-common jq zip shellcheck \
    # install networking related packages
    ca-certificates apt-transport-https dnsutils gnupg2 httpie inetutils-ping inetutils-tools inetutils-traceroute net-tools ;\ 
    apt-get update

# Create the developer user and set permissions
RUN chsh -s /bin/bash ;\
    sed -i 's/# en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && locale-gen ;\
    mkdir -p /usr/bin/strong_network_startup ;\
    chown root:root /usr/bin/fixuid ;\
    chmod 4755 /usr/bin/fixuid ;\
    mkdir -p /etc/fixuid ;\
    printf 'user: developer\ngroup: developer\n' > /etc/fixuid/config.yml ;\
    adduser --gecos '' --disabled-password developer ;\
    echo 'developer ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/nopasswd ;\
    # Change permissions of /usr/local
    chgrp -R developer /usr/local ;\
    chmod -R g+w /usr/local ;\
    mkdir -p /home/developer ;\
    chown -R developer /home/developer ;\
    chmod -R 770 /home/developer

COPY unzip_ide.sh /unzip_ide.sh
COPY --chown=developer:developer install_go_tools.sh /install_go_tools.sh
COPY --chown=developer:developer install_nodejs_tools.sh /install_nodejs_tools.sh

RUN bash install_nodejs_tools.sh && rm install_nodejs_tools.sh ;\
    mv install_go_tools.sh /usr/bin/strong_network_startup/install_go_tools.sh ;\
    chmod 4755 /usr/bin/strong_network_startup/install_go_tools.sh ;\
    chmod +x /unzip_ide.sh