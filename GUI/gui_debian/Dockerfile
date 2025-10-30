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