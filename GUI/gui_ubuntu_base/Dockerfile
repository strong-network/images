# syntax=docker/dockerfile:experimental
ARG BASE_IMAGE=ubuntu:24.04
FROM ${BASE_IMAGE}

ARG user=developer
ARG group=developer
ARG uid=1000
ARG gid=1000

#### #### Strong Network #### ####
RUN apt-get update && \
    apt-get install -y git locales sudo curl \
    libkrb5-dev libssl-dev

RUN usermod -u 2000 ubuntu && groupmod -g 2000 ubuntu && groupadd -g ${gid} ${group} && \
    adduser --home /home/${user} --uid ${uid} --gid ${gid} --gecos 'sn_user' --disabled-password ${user} && \
    echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && apt-get update && \
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
# install gnome desktop
RUN apt-get install -y ubuntu-desktop ubuntu-gnome-desktop gnome-core gnome-panel gnome-tweaks
# install xfce4 desktop
RUN apt-get install -y xfce4 xfce4-goodies
# install novnc and tightvnc
# we opt for TightVNC over TigerVNC because TightVNC offers robust support for both GNOME and XFCE4 desktop environments on Ubuntu 22.04.
RUN apt-get install -y novnc tightvncserver
RUN apt-get install -y vim
# To get clipboard support
RUN apt-get install autocutsel
# Mesa OpenGL
RUN apt-get install -y --no-install-recommends libglu1-mesa-dev mesa-utils dbus-x11 gstreamer1.0-tools libpci-dev libx11-dev
# copy vnc startup scripts
RUN  mkdir -p /usr/bin/strong_network_startup/xstartup && chmod 777 /usr/bin/strong_network_startup/xstartup
COPY tools/index.html /usr/share/novnc/index.html
COPY tools/favicon.png /usr/share/novnc/app/images/icons/favicon.png
COPY tools/initialize_workspace.sh /usr/bin/strong_network_startup/xstartup/initialize_workspace.sh
COPY tools/xstartup.gnome          /usr/bin/strong_network_startup/xstartup/xstartup.gnome
COPY tools/xstartup.xfce4          /usr/bin/strong_network_startup/xstartup/xstartup.xfce4
RUN chmod +x /usr/bin/strong_network_startup/xstartup/initialize_workspace.sh
# Remove power manager to remove the dialog first run
RUN apt-get remove -y xfce4-power-manager xfce4-power-manager-data
RUN update-alternatives --set x-terminal-emulator /usr/bin/xfce4-terminal.wrapper
ENV vnc_ready=true
#### #### NoVNC #### ####

USER ${user}
WORKDIR /home/developer