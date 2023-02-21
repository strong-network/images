FROM ubuntu:22.04

ENV SHELL=/bin/bash
ENV LANG=en_US.UTF-8
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

COPY validate_file_hash.sh /validate_file_hash

# Install base packages for other applications and update the package repository
RUN apt-get update ;\
    apt-get install -y git wget python2 python3-dev python3-pip python3-venv curl libffi-dev \
    libsecret-1-dev libx11-dev libxkbfile-dev gettext-base rsync sudo \
    libkrb5-dev libssl-dev build-essential clang-format clang dirmngr lsb-release ;\
    DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get -y install unzip libxext6 libxrender1 libxtst6 libxi6 libfreetype6 ;\
    chmod +x /validate_file_hash

# Download docker tools
RUN wget https://download.docker.com/linux/static/stable/x86_64/docker-20.10.19.tgz -O  docker.tar.gz ;\
    /validate_file_hash ddcd732baaa03958cc8f326a5dca09bcd8f348bb7d2737aaf67bbdd7d80302d1 docker.tar.gz ;\
    tar -C /tmp -xzf docker.tar.gz ;\
    rm docker.tar.gz ;\
    mv /tmp/docker/docker /usr/bin/ ;\
    rm -r /tmp/docker ;\
    wget https://github.com/docker/compose/releases/download/v2.14.0/docker-compose-linux-x86_64 -O /usr/local/bin/docker-compose ;\
    /validate_file_hash f15a7cd54a85f760a8ece92da63fb85b93036c72ead8056391b8a3fe9dc73134 /usr/local/bin/docker-compose ;\
    chmod +x /usr/local/bin/docker-compose ;\
    mkdir -p /usr/bin/strong_network_startup

# Install kubernetes related tools
RUN wget -O helm.tar.gz https://get.helm.sh/helm-v3.10.2-linux-amd64.tar.gz ;\
    /validate_file_hash 2315941a13291c277dac9f65e75ead56386440d3907e0540bf157ae70f188347 helm.tar.gz ;\
    tar -C /tmp -xzf helm.tar.gz ;\
    mv /tmp/linux-amd64/helm /usr/local/bin ;\
    rm helm.tar.gz ;\
    rm -r /tmp/linux-amd64 ;\
    wget -O kubectl https://storage.googleapis.com/kubernetes-release/release/v1.23.3/bin/linux/amd64/kubectl ;\
    /validate_file_hash d7da739e4977657a3b3c84962df49493e36b09cc66381a5e36029206dd1e01d0 kubectl ;\
    mv kubectl /usr/local/bin ;\
    chmod 4755 /usr/local/bin/kubectl

# Install cloud specific CLI tools
RUN wget -O doctl.tar.gz https://github.com/digitalocean/doctl/releases/download/v1.88.0/doctl-1.88.0-linux-amd64.tar.gz ;\
    /validate_file_hash e5180c3b69fd06086a21f3f99e1527ffefc1e90a60808171a51d5c6f8719cf7a doctl.tar.gz ;\
    tar -C /usr/local/bin -xzf doctl.tar.gz ;\
    rm doctl.tar.gz ;\
    # Install AWS cli
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" ;\
    /validate_file_hash 3a37be4ac0d790b00db7664e95c40db81c4a9c37f4222846d6bd9acdc0c03791 awscliv2.zip ;\
    unzip awscliv2.zip ;\
    ./aws/install ;\
    rm -rf aws ;\
    # Install  Azure CLi
    mkdir -p /etc/apt/keyrings ;\
    curl -sLS https://packages.microsoft.com/keys/microsoft.asc > microsoft.asc ;\
    cat microsoft.asc | gpg --dearmor | tee /etc/apt/keyrings/microsoft.gpg > /dev/null ;\
    cat microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/powershell.gpg > /dev/null ;\
    chmod go+r /etc/apt/keyrings/microsoft.gpg ;\
    /validate_file_hash b4dcc2fb98c13b5fc96aee6cd7e3c1e82516f57fab40df83f57dfed1820cb981  /etc/apt/keyrings/microsoft.gpg ;\
    AZ_REPO=$(lsb_release -cs) ;\
    echo "deb [arch=amd64,armhf,arm64 signed-by=/usr/share/keyrings/powershell.gpg] https://packages.microsoft.com/ubuntu/22.04/prod/ jammy main" | tee /etc/apt/sources.list.d/powershell.list ;\
    echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | tee /etc/apt/sources.list.d/azure-cli.list ;\
    apt-get update ;\
    apt-get install azure-cli powershell

# Install hashcorp/terraform tools
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg > hashicorp.key ;\
    /validate_file_hash cafb01beac341bf2a9ba89793e6dd2468110291adfbb6c62ed11a0cde6c09029  hashicorp.key ;\
    cat hashicorp.key | apt-key add - ;\
    rm hashicorp.key ;\
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" ;\
    apt-get update ;\
    apt-get install terraform -y ;\
    curl -L "$(curl -s https://api.github.com/repos/tenable/terrascan/releases/latest | grep -o -E "https://.+?_Linux_x86_64.tar.gz")" > terrascan.tar.gz  ;\
    /validate_file_hash 9b56dc92643c3e88c4fb634fff283c4a8c0f535f827bf1e18d39084f7181b077  terrascan.tar.gz ;\
    tar -xf terrascan.tar.gz terrascan && rm terrascan.tar.gz ;\
    install terrascan /usr/local/bin && rm terrascan ;\
    curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh > install_tflint.sh ;\
    /validate_file_hash 0f606a0a472f857a9d34e9978a2d344a19ed36ffae43085e7d4736f253238105  install_tflint.sh && cat install_tflint.sh | bash && rm install_tflint.sh ;\
    curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh > install_tfsec.sh ;\
    /validate_file_hash c1620085730cc45e4ba3b023fffeca2c58b8260561fb34cf52d7ad21d494134a  install_tfsec.sh && cat install_tfsec.sh | bash && rm install_tfsec.sh 

RUN wget https://github.com/boxboat/fixuid/releases/download/v0.5.1/fixuid-0.5.1-linux-amd64.tar.gz -O fixuid-linux-amd64.tar.gz ;\
    tar -C /usr/bin -xzf fixuid-linux-amd64.tar.gz ;\
    rm fixuid-linux-amd64.tar.gz 


# Setup environment for developers
    # install general packages related to development
RUN apt-get install -y  git-lfs git htop less locales man nano  ssh sudo tmux vim emacs asciinema \
    zsh software-properties-common jq zip shellcheck \
    nodejs yarn npm openjdk-11-jdk \
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
COPY --chown=developer:developer install_go_tools.sh /usr/bin/strong_network_startup/install_go_tools.sh
COPY --chown=developer:developer install_nodejs_tools.sh /install_nodejs_tools.sh

RUN chmod 4755 /usr/bin/strong_network_startup/install_go_tools.sh && chmod +x /unzip_ide.sh ;\