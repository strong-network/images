FROM ubuntu:24.04

ENV SHELL=/bin/bash
ENV LANG=en_US.UTF-8
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# The minimum requirements to run a Strong Network workspace
RUN apt-get update && \
    apt-get install -y git locales sudo curl \
    libkrb5-dev libssl-dev && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && apt-get update && \
    DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get -y install git-lfs ssh && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata && \
    chsh -s /bin/bash && \
    sed -i 's/# en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && locale-gen && \
    mkdir -p /usr/bin/strong_network_startup && chmod 777 /usr/bin/strong_network_startup && \
    usermod -u 2000 ubuntu && groupmod -g 2000 ubuntu && \
    adduser --gecos '' --disabled-password developer && \
    # Change permissions of /usr/local
    chgrp -R developer /usr/local && \
    chmod -R g+w /usr/local && \
    echo 'developer ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/nopasswd
# End of minimum requirements to run a Strong Network workspace

COPY validate_file_hash.sh /validate_file_hash

# Optional Install user space packages
RUN apt-get install -y wget python3-dev python3-pip python3-venv software-properties-common libffi-dev nano tmux vim emacs asciinema \
    build-essential clang-format clang libsecret-1-dev libx11-dev libxkbfile-dev gettext-base rsync libxext6 libxrender1 libxtst6 unzip \ 
    libxi6 libfreetype6 dirmngr lsb-release less && \
    mkdir -p /usr/bin/strong_network_startup/vscode_extensions && chmod 777 /usr/bin/strong_network_startup/vscode_extensions && \
    chown 1000:1000 /usr/bin/strong_network_startup/vscode_extensions && \
    mkdir -p /home/developer && \
    chown -R developer /home/developer && \
    chmod -R 770 /home/developer

# Optional Download docker tools
RUN chmod +x /validate_file_hash && wget https://download.docker.com/linux/static/stable/x86_64/docker-29.0.2.tgz -O docker.tar.gz && \
    /validate_file_hash 079e491e942e7a7a090c593db7eb63f3d657b5ca166c38dab59678b165b91eca docker.tar.gz && \
    tar -C /tmp -xzf docker.tar.gz && \
    rm docker.tar.gz && \
    mv /tmp/docker/docker /usr/bin/ && \
    rm -r /tmp/docker && \
    mkdir -p /usr/local/lib/docker/cli-plugins && \
    wget https://github.com/docker/buildx/releases/download/v0.30.1/buildx-v0.30.1.linux-amd64 -O /usr/local/lib/docker/cli-plugins/docker-buildx  && \
    chmod +x /usr/local/lib/docker/cli-plugins/docker-buildx && \
    wget https://github.com/docker/compose/releases/download/v2.40.3/docker-compose-linux-x86_64 -O /usr/local/bin/docker-compose && \
    /validate_file_hash dba9d98e1ba5bfe11d88c99b9bd32fc4a0624a30fafe68eea34d61a3e42fd372 /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    mkdir -p /usr/bin/strong_network_startup

# Install and setup chromium and dependencies
RUN add-apt-repository ppa:xtradeb/apps -y && \
    apt-get update && apt-get install -y xvfb chromium libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libnss3 libxss1 xauth 

ADD xvfb-chromium /usr/bin/xvfb-chromium

RUN chmod +x /usr/bin/xvfb-chromium && \
    ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome && \
    ln -s /usr/bin/xvfb-chromium /usr/bin/chromium-browser

RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && apt-get install nodejs -y && \
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg > yarn.gpg.key && \
    /validate_file_hash 8550a7e298b523fffa899069754fc150f2ff74092701e4d4109edd1cd6d5327f  yarn.gpg.key && cat yarn.gpg.key | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get -y install make yarn && \
    apt-get install -y htop zsh jq zip shellcheck tree nodejs \
    # install networking related packages
    ca-certificates apt-transport-https dnsutils gnupg2 httpie inetutils-ping inetutils-tools inetutils-traceroute net-tools && \
    apt-get update && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt

USER 1000
WORKDIR /home/developer