# syntax=docker/dockerfile:experimental
ARG BASE_IMAGE=ubuntu:22.04
FROM ${BASE_IMAGE}

ARG user=developer
ARG group=developer
ARG uid=1000
ARG gid=1000

RUN groupadd -g ${gid} ${group}
RUN adduser --home /home/${user} --uid ${uid} --gid ${gid} --gecos 'sn_user' --disabled-password ${user}
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


#### #### VSCode #### ####
# add microsoft's gpg key and the vscode repository
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    sh -c 'echo "deb [arch=amd64,arm64,armhf] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' && \
    rm microsoft.gpg
# install vsCode
RUN apt-get update && \
    apt-get install -y code
#### #### VSCode #### ###


#### #### NoVNC #### ####
# install gnome desktop
RUN apt-get install -y ubuntu-desktop ubuntu-gnome-desktop gnome-core gnome-panel gnome-tweaks
# install xfce4 desktop
RUN apt-get install -y xfce4 xfce4-goodies
# install novnc and tightvnc
# we opt for TightVNC over TigerVNC because TightVNC offers robust support for both GNOME and XFCE4 desktop environments on Ubuntu 22.04.
RUN apt-get install -y novnc tightvncserver
# install python3 and chrome
RUN apt-get install -y python3-dev python3-pip  wget vim
RUN python3 -m pip install --upgrade pip
RUN apt-get install -y wget vim

# copy vnc startup scripts
RUN  mkdir -p /usr/bin/strong_network_startup/xstartup && chmod 777 /usr/bin/strong_network_startup/xstartup
COPY tools/index.html /usr/share/novnc/index.html
COPY tools/initialize_workspace.sh /usr/bin/strong_network_startup/xstartup/initialize_workspace.sh
COPY tools/xstartup.gnome          /usr/bin/strong_network_startup/xstartup/xstartup.gnome
COPY tools/xstartup.xfce4          /usr/bin/strong_network_startup/xstartup/xstartup.xfce4

RUN chmod +x /usr/bin/strong_network_startup/xstartup/initialize_workspace.sh

# Remove power manager to remove the dialog first run
RUN apt-get remove -y xfce4-power-manager xfce4-power-manager-data
#### #### NoVNC #### ####

#### #### Setup Eclipse #### ####
ARG eclipseVersion=2024-06/R/eclipse-committers-2024-06-R-linux-gtk-x86_64.tar.gz
COPY tools/eclipse.desktop /opt/eclipse.desktop
RUN wget -O eclipse.tar.gz http://www.mirrorservice.org/sites/download.eclipse.org/eclipseMirror/technology/epp/downloads/release/${eclipseVersion} && \
    tar -xvzf eclipse.tar.gz --directory /opt && \
    desktop-file-install /opt/eclipse.desktop && mkdir /home/developer/Desktop && cp /opt/eclipse.desktop /home/developer/Desktop/eclipse.desktop && \
    chmod +x /home/developer/Desktop/eclipse.desktop && rm rm eclipse.tar.gz
#### #### Setup Eclipse #### ####

# Install python3
RUN apt-get install -y python3-dev python3-pip wget vim
RUN python3 -m pip install --upgrade pip

# Install Chrome
# RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
#     sudo apt install -y ./google-chrome-stable_current_amd64.deb && \
#     rm google-chrome-stable_current_amd64.deb

USER ${user}
WORKDIR /home/developer