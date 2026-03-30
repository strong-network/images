# syntax=docker/dockerfile:experimental
ARG BASE_IMAGE=debian:bookworm-slim
FROM ${BASE_IMAGE}

ARG user=developer
ARG group=developer
ARG uid=1000
ARG gid=1000

RUN groupadd -g ${gid} ${group}
RUN adduser --home /home/${user} --uid ${uid} --gid ${gid} --gecos 'sds_user' --disabled-password ${user}
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

#### #### Strong Network #### ####
RUN apt-get update && \
    apt-get install -y git locales sudo curl wget make build-essential gawk bison \
    libkrb5-dev libssl-dev && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && apt-get update && \
    DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get -y install git-lfs ssh && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata && \
    chsh -s /bin/bash && \
    sed -i 's/# en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && locale-gen && \
    mkdir -p /usr/bin/strong_network_startup && chmod 777 /usr/bin/strong_network_startup && \
    # Change permissions of /usr/local
    chgrp -R ${group} /usr/local && \
    chmod -R g+w /usr/local && \
    echo 'developer ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/nopasswd
#### #### Strong Network #### ####

COPY validate_file_hash.sh /validate_file_hash

# Download docker tools
RUN chmod +x /validate_file_hash && wget https://download.docker.com/linux/static/stable/x86_64/docker-29.1.5.tgz -O docker.tar.gz && \
    /validate_file_hash 882bb03f3fd36ad565b1362f5bbb5d5af5f2410a5c10cae3f9d3d54e2540adc2 docker.tar.gz && \
    tar -C /tmp -xzf docker.tar.gz && \
    rm docker.tar.gz && \
    mv /tmp/docker/docker /usr/bin/ && \
    rm -r /tmp/docker && \
    mkdir -p /usr/local/lib/docker/cli-plugins && \
    wget https://github.com/docker/buildx/releases/download/v0.31.0/buildx-v0.31.0.linux-amd64 -O /usr/local/lib/docker/cli-plugins/docker-buildx  && \
    /validate_file_hash 39cc424a730d8b7364c23a137582cb29e7f024b175bb595001ff6f90121b005b /usr/local/lib/docker/cli-plugins/docker-buildx && \
    chmod +x /usr/local/lib/docker/cli-plugins/docker-buildx && \
    wget https://github.com/docker/compose/releases/download/v5.0.2/docker-compose-linux-x86_64 -O /usr/local/bin/docker-compose && \
    /validate_file_hash 2d880f723d3da7c779c54fdaea91a842fca8af55d1397f1ed8d7cbab3dd7af67 /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    mkdir -p /usr/bin/strong_network_startup

#### #### NoVNC #### ####
# # install xfce4 desktop
RUN apt-get install -y xfce4 xfce4-goodies dbus-x11
# install novnc and TigerVNC
RUN apt-get install -y novnc tigervnc-standalone-server tigervnc-common

RUN apt-get install -y vim net-tools
# To get clipboard support
RUN apt-get install autocutsel
# copy vnc startup scripts
RUN  mkdir -p /usr/bin/strong_network_startup/xstartup && chmod 777 /usr/bin/strong_network_startup/xstartup
COPY tools/index.html /usr/share/novnc/index.html
COPY tools/favicon.png /usr/share/novnc/app/images/icons/favicon.png
COPY tools/initialize_workspace.sh /usr/bin/strong_network_startup/xstartup/initialize_workspace.sh
COPY tools/xstartup.xfce4          /usr/bin/strong_network_startup/xstartup/xstartup.xfce4
RUN chmod +x /usr/bin/strong_network_startup/xstartup/initialize_workspace.sh
# Remove power manager to remove the dialog first run
RUN apt-get remove -y xfce4-power-manager xfce4-power-manager-data
# RUN update-alternatives --set x-terminal-emulator /usr/bin/xfce4-terminal.wrapper
ENV vnc_ready=true
#### #### NoVNC #### ####



COPY tools/install_tools.sh /tmp/install_tools.sh
RUN chmod +x /tmp/install_tools.sh && \
    /tmp/install_tools.sh && \
    rm /tmp/install_tools.sh

USER ${user}
WORKDIR /home/developer
