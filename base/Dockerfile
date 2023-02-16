FROM ubuntu:22.04

ENV SHELL=/bin/bash
ENV LANG=en_US.UTF-8
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# install base packages and dependencies
RUN apt-get update && apt-get install -y build-essential clang-format clang curl git-lfs git htop less libffi-dev libkrb5-dev libssl-dev \
    locales man nano python3-dev python3-pip python3-venv ssh sudo tmux vim wget zsh software-properties-common ;\
    DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt -y install unzip openjdk-11-jdk libxext6 libxrender1 libxtst6 libxi6 libfreetype6 maven ;\
    chsh -s /bin/bash ;\
    sed -i 's/# en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && locale-gen ;\
    wget https://download.docker.com/linux/static/stable/x86_64/docker-20.10.19.tgz -O  docker.tar.gz ;\
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

RUN mkdir -p /usr/bin/strong_network_startup ;\
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

RUN  chmod +x /unzip_ide.sh