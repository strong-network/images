FROM alpine:3.20.0

ENV SHELL=/bin/bash
ENV LANG=en_US.UTF-8
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apk update && \
    apk add --no-cache git openssh curl bash sudo git-lfs krb5-dev openssl-dev tzdata gcompat libgcc libstdc++ ncurses-libs

RUN mkdir -p /usr/bin/strong_network_startup && chmod 777 /usr/bin/strong_network_startup && \
    adduser -D -g '' developer && \
    # Change permissions of /usr/local
    chgrp -R developer /usr/local && \
    chmod -R g+w /usr/local && \
    echo 'developer ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/nopasswd

RUN mkdir -p /usr/bin/strong_network_startup/vscode_extensions && chmod 777 /usr/bin/strong_network_startup/vscode_extensions && \
    chown 1000:1000 /usr/bin/strong_network_startup/vscode_extensions && \
    mkdir -p /home/developer && \
    chown -R developer /home/developer && \
    chmod -R 770 /home/developer

RUN apk update && apk add --no-cache docker-cli

USER 1000
WORKDIR /home/developer