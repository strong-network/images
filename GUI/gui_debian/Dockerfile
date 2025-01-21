FROM kalilinux/kali-last-release:latest

ENV SHELL=/bin/bash
ENV LANG=en_US.UTF-8
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

COPY validate_file_hash.sh /validate_file_hash

# Install base packages for other applications and update the package repository
RUN apt-get update && \
    apt-get install -y git wget python2 python3-dev python3-pip python3-venv curl libffi-dev kali-linux-core tigervnc-standalone-server dbus-x11 kali-desktop-xfce novnc xorg xrdp \
    libsecret-1-dev libx11-dev libxkbfile-dev gettext-base rsync sudo software-properties-common \
    libkrb5-dev libssl-dev build-essential clang-format clang dirmngr lsb-release && \
    DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get -y install unzip libxext6 libxrender1 libxtst6 libxi6 libfreetype6 && \
    chmod +x /validate_file_hash

# Download docker tools
RUN wget https://download.docker.com/linux/static/stable/x86_64/docker-20.10.24.tgz -O docker.tar.gz && \
    /validate_file_hash ab91092320a87691a1eaf0225b48585db9c69cff0ed4b0f569f744ff765515e3 docker.tar.gz && \
    tar -C /tmp -xzf docker.tar.gz && \
    rm docker.tar.gz && \
    mv /tmp/docker/docker /usr/bin/ && \
    rm -r /tmp/docker && \
    wget https://github.com/docker/compose/releases/download/v2.24.1/docker-compose-linux-x86_64 -O /usr/local/bin/docker-compose && \
    /validate_file_hash d350bbbd1c74c0a8542193bd41881afea534b141c6a9d9a27b2f217e51d5c48c /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    mkdir -p /usr/bin/strong_network_startup

# Install kubernetes related tools
RUN wget -O helm.tar.gz https://get.helm.sh/helm-v3.14.0-linux-amd64.tar.gz && \
    /validate_file_hash f43e1c3387de24547506ab05d24e5309c0ce0b228c23bd8aa64e9ec4b8206651 helm.tar.gz && \
    tar -C /tmp -xzf helm.tar.gz && \
    mv /tmp/linux-amd64/helm /usr/local/bin && \
    rm helm.tar.gz && \
    rm -r /tmp/linux-amd64 && \
    wget -O kubectl https://storage.googleapis.com/kubernetes-release/release/v1.29.1/bin/linux/amd64/kubectl && \
    /validate_file_hash 69ab3a931e826bf7ac14d38ba7ca637d66a6fcb1ca0e3333a2cafdf15482af9f kubectl && \
    mv kubectl /usr/local/bin && \
    chmod 4755 /usr/local/bin/kubectl

# Install cloud specific CLI tools
RUN wget -O doctl.tar.gz https://github.com/digitalocean/doctl/releases/download/v1.103.0/doctl-1.103.0-linux-amd64.tar.gz && \
    /validate_file_hash 14c9f6984299a80ad3fbe8e9711d503667c203e2768c04cdcde8dcf4a61ca8fe doctl.tar.gz && \
    tar -C /usr/local/bin -xzf doctl.tar.gz && \
    rm doctl.tar.gz && \
    # Install AWS cli
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.15.12.zip" -o "awscliv2.zip" && \
    /validate_file_hash 81077b6920d9163df429f27f28b53af534c98e6f823a496cc11cab75eec78ab4 awscliv2.zip && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm awscliv2.zip && \
    rm -rf aws

# Setup environment for developers
    # install general packages related to development
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && apt-get install nodejs -y && \
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg > yarn.gpg.key && \
    /validate_file_hash 8550a7e298b523fffa899069754fc150f2ff74092701e4d4109edd1cd6d5327f  yarn.gpg.key && cat yarn.gpg.key | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get -y install gcc g++ make yarn && \
    # script is to have the latest available version of git-lfs
    apt-get install -y  git-lfs git htop less locales man nano  ssh sudo tmux vim emacs asciinema \
    zsh  jq zip shellcheck tree \
    nodejs openjdk-11-jdk \
    # install networking related packages
    ca-certificates apt-transport-https dnsutils gnupg2 httpie inetutils-ping inetutils-tools inetutils-traceroute net-tools && \
    apt-get update && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt

# Create the developer user and set permissions
RUN chsh -s /bin/bash && \
    sed -i 's/# en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && locale-gen && \
    mkdir -p /usr/bin/strong_network_startup/vscode_extensions && \
    adduser --gecos '' --disabled-password developer && \
    echo 'developer ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/nopasswd && \
    # Change permissions of /usr/local
    chgrp -R developer /usr/local && \
    chmod -R g+w /usr/local && \
    mkdir -p /home/developer && \
    chown -R developer /home/developer && \
    chmod -R 770 /home/developer && \
    chmod 777 /usr/bin/strong_network_startup/vscode_extensions && chown 1000:1000 /usr/bin/strong_network_startup/vscode_extensions
COPY unzip_ide.sh /unzip_ide.sh
COPY --chown=developer:developer install_go_tools.sh /usr/bin/strong_network_startup/install_go_tools.sh

COPY xstartup /xstartup
COPY setup_vnc.sh /usr/bin/strong_network_startup/setup_vnc.sh

RUN wget https://gitlab.com/kalilinux/recipes/kali-scripts/-/raw/main/xfce4.sh && \
    chmod +x xfce4.sh && \
    ./xfce4.sh && \
    cp /usr/share/novnc/vnc_auto.html /usr/share/novnc/index.html

RUN chmod 4755 /usr/bin/strong_network_startup/install_go_tools.sh && chmod +x /unzip_ide.sh && chmod +x /usr/bin/strong_network_startup/install_go_tools.sh &&\
    curl -s https://get.sdkman.io > /tmp/install_sdkman.sh &&\
    cd /tmp &&\
    /validate_file_hash f1893baeb6f240611acef7ec3c277153b65ac2cd925099ec85b6076f232ddc9d install_sdkman.sh &&\
    export SDKMAN_DIR=/tmp/sdkman &&\
    bash /tmp/install_sdkman.sh &&\
    bash -c "source /tmp/sdkman/bin/sdkman-init.sh && sdk install grails" &&\
    echo '#!/bin/bash\n\
    if ! grep -q SDKMAN_DIR "/home/developer/.bashrc" ; then\n\
        cp -r /tmp/sdkman /home/developer/.sdkman\n\
        echo "SDKMAN_DIR=/home/developer/.sdkman" >> ~/.bashrc\n\
        echo "[[ -s $HOME/.sdkman/bin/sdkman-init.sh ]] && source     $HOME/.sdkman/bin/sdkman-init.sh" >> $HOME/.bashrc  \n\
    fi \n' > /usr/bin/strong_network_startup/add_sdk.sh &&\
    chown -R developer:developer /usr/bin/strong_network_startup/add_sdk.sh &&\
    chmod +x  /usr/bin/strong_network_startup/add_sdk.sh

WORKDIR /home/developer

USER 1000