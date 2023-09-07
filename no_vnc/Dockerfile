FROM ubuntu:20.04

ENV SHELL=/bin/bash
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LANG=en_US.UTF-8
ENV DISPLAY=:1
ENV XAUTHORITY=/developer/.Xauthority
ENV VNC_PORT=5901
ENV NO_VNC_PORT=6901
ENV HOME=/developer
ENV TERM=xterm
ENV DEBIAN_FRONTEND=noninteractive
ENV VNC_COL_DEPTH=24
ENV VNC_RESOLUTION=1920x1080
ENV VNC_PW=vncpassword

COPY validate_file_hash.sh /validate_file_hash

COPY generate_container_user.sh /generate_container_user.sh
COPY setup_vnc.sh /setup_vnc.sh
COPY start_vnc.sh /start_vnc.sh

RUN apt-get update && \
    apt-get install -y wget apt-utils bash bzip2 make libreoffice \
    dbus-x11 dumb-init gettext git-lfs git gstreamer1.0-tools \
    libnss-wrapper libnss3-tools libpci-dev libx11-dev \
    libxtst-dev locales openssl software-properties-common \
    sudo tigervnc-common tigervnc-standalone-server tigervnc-xorg-extension
    
RUN apt-get install -y --no-install-recommends xfce4 && \
    chmod +x /validate_file_hash

RUN sed -i 's/# en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && locale-gen && \
    adduser --gecos '' --disabled-password developer && \
    echo 'developer ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/nopasswd

RUN wget -O no_vnc.tar.gz https://github.com/novnc/noVNC/archive/v1.2.0.tar.gz && \
    /validate_file_hash 36c476b26df4684f1002e15c3d7e034c9e6ee4521e5fa8aac37309f954a07a01 no_vnc.tar.gz && \
    mkdir -m 777 -p /developer/.noVNC && \
    tar -xf no_vnc.tar.gz --strip 1 -C /developer/.noVNC && \
    cp /developer/.noVNC/vnc.html /developer/.noVNC/index.html && \
    wget -O websockify.tar.gz https://github.com/novnc/websockify/archive/v0.10.0.tar.gz && \
    /validate_file_hash 7bd99b727e0be230f6f47f65fbe4bd2ae8b2aa3568350148bdf5cf440c4c6b4a websockify.tar.gz && \
    mkdir -p /developer/.noVNC/utils/websockify && \
    tar -xf  websockify.tar.gz --strip 1 -C /developer/.noVNC/utils/websockify && \
    chmod +x -v /developer/.noVNC/utils/*.sh && \
    rm no_vnc.tar.gz && rm websockify.tar.gz && \
    sed -i 's/${WEBSOCKIFY}/${WEBSOCKIFY} --heartbeat=30/' /developer/.noVNC/utils/launch.sh

RUN add-apt-repository ppa:kisak/kisak-mesa && \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y mesa-utils libglu1-mesa-dev && \
    echo 'source /generate_container_user.sh' >> /developer/.bashrc && \
    rm /validate_file_hash

            # Run setup VNC
RUN chmod +x /setup_vnc.sh && \
    /setup_vnc.sh && \
    rm /setup_vnc.sh  && \
    chmod +x start_vnc.sh

    # Change ownership of folder
RUN chown -R developer /developer && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt