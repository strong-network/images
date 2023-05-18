FROM ubuntu:22.04

ENV SHELL=/bin/bash
ENV LANG=en_US.UTF-8
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

COPY validate_file_hash.sh /validate_file_hash

# Install base packages for other applications and update the package repository
RUN apt-get update && \
    apt-get install -y git wget python2 python3-dev python3-pip python3-venv curl libffi-dev \
    libsecret-1-dev libx11-dev libxkbfile-dev gettext-base rsync sudo software-properties-common \
    libkrb5-dev libssl-dev build-essential clang-format clang dirmngr lsb-release && \
    DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get -y install unzip libxext6 libxrender1 libxtst6 libxi6 libfreetype6 && \
    chmod +x /validate_file_hash

# Download docker tools
RUN wget https://download.docker.com/linux/static/stable/x86_64/docker-20.10.24.tgz -O  docker.tar.gz && \
    /validate_file_hash ab91092320a87691a1eaf0225b48585db9c69cff0ed4b0f569f744ff765515e3 docker.tar.gz && \
    tar -C /tmp -xzf docker.tar.gz && \
    rm docker.tar.gz && \
    mv /tmp/docker/docker /usr/bin/ && \
    rm -r /tmp/docker && \
    wget https://github.com/docker/compose/releases/download/v2.18.0/docker-compose-linux-x86_64 -O /usr/local/bin/docker-compose && \
    /validate_file_hash 02b69f1f23167fce126b16d9d6b645362f5a6fa7fc9a073d3d080e45e12d32fc   /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    mkdir -p /usr/bin/strong_network_startup

# Install kubernetes related tools
RUN wget -O helm.tar.gz https://get.helm.sh/helm-v3.12.0-linux-amd64.tar.gz && \
    /validate_file_hash da36e117d6dbc57c8ec5bab2283222fbd108db86c83389eebe045ad1ef3e2c3b helm.tar.gz && \
    tar -C /tmp -xzf helm.tar.gz && \
    mv /tmp/linux-amd64/helm /usr/local/bin && \
    rm helm.tar.gz && \
    rm -r /tmp/linux-amd64 && \
    wget -O kubectl https://storage.googleapis.com/kubernetes-release/release/v1.27.1/bin/linux/amd64/kubectl && \
    /validate_file_hash 7fe3a762d926fb068bae32c399880e946e8caf3d903078bea9b169dcd5c17f6d kubectl && \
    mv kubectl /usr/local/bin && \
    chmod 4755 /usr/local/bin/kubectl

# Install cloud specific CLI tools
RUN wget -O doctl.tar.gz https://github.com/digitalocean/doctl/releases/download/v1.95.0/doctl-1.95.0-linux-amd64.tar.gz && \
    /validate_file_hash 6426a1727b4729e8de3225c9a3683e874c76bb2ddcf5e1a0dca8e6ec438f1f31 doctl.tar.gz && \
    tar -C /usr/local/bin -xzf doctl.tar.gz && \
    rm doctl.tar.gz && \
    # Install AWS cli
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.11.20.zip" -o "awscliv2.zip" && \
    /validate_file_hash 639ea246a1195290416f64471434ac74ccfe0a4e5dff0a5375447d6c05648917 awscliv2.zip && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm awscliv2.zip && \ 
    rm -rf aws
    
# Install  Azure CLi
RUN mkdir -p /etc/apt/keyrings && \
    curl -sLS https://packages.microsoft.com/keys/microsoft.asc > microsoft.asc && \
    cat microsoft.asc | gpg --dearmor | tee /etc/apt/keyrings/microsoft.gpg > /dev/null && \
    cat microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/powershell.gpg > /dev/null && \
    chmod go+r /etc/apt/keyrings/microsoft.gpg && \
    /validate_file_hash b4dcc2fb98c13b5fc96aee6cd7e3c1e82516f57fab40df83f57dfed1820cb981  /etc/apt/keyrings/microsoft.gpg && \
    AZ_REPO=$(lsb_release -cs) && \
    wget -O powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v7.3.4/powershell_7.3.4-1.deb_amd64.deb && \
    /validate_file_hash 1447a6d90aa66616757290e8a4bde7df0ee14d9b77aba8d73021e849ad12f418 powershell.tar.gz && \
    dpkg -i powershell.tar.gz && \
    apt-get install -f && \
    echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | tee /etc/apt/sources.list.d/azure-cli.list && \
    apt-get update && \
    apt-get install -y azure-cli && \
    rm powershell.tar.gz && \
    rm -rf /etc/apt/sources.list.d/azure-cl.list && \
    apt-get update

# Install hashcorp/terraform tools
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg > hashicorp.key && \
    /validate_file_hash cafb01beac341bf2a9ba89793e6dd2468110291adfbb6c62ed11a0cde6c09029 hashicorp.key && \
    cat hashicorp.key | apt-key add - && \
    rm hashicorp.key && \
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt-get update && \
    apt-get install terraform -y && \
    curl -L "$(curl -s https://api.github.com/repos/tenable/terrascan/releases/latest | grep -o -E "https://.+?_Linux_x86_64.tar.gz")" > terrascan.tar.gz  && \
    /validate_file_hash 5ee633b203479338fe5c0bfac6c3a5f9d3da3760c4ed431d339d24f365ff4465 terrascan.tar.gz && \
    tar -xf terrascan.tar.gz terrascan && rm terrascan.tar.gz && \
    install terrascan /usr/local/bin && rm terrascan && \
    curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh > install_tflint.sh && \
    /validate_file_hash 0f606a0a472f857a9d34e9978a2d344a19ed36ffae43085e7d4736f253238105 install_tflint.sh && cat install_tflint.sh | bash && rm install_tflint.sh && \
    curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh > install_tfsec.sh && \
    /validate_file_hash c6621a5be84cdecc292cee9745470519dbc1cf38637525f4dc3310ea9101ec90 install_tfsec.sh && cat install_tfsec.sh | bash && rm install_tfsec.sh 


# Setup environment for developers
    # install general packages related to development
RUN curl -fsSL https://deb.nodesource.com/setup_19.x > install_nodejs.sh && \
    /validate_file_hash 0d23e75796f29fb5830839e94a81f6abd3c257b544c7c51e3d157a5c69a6718f install_nodejs.sh && \
    cat install_nodejs.sh | sudo -E bash && rm install_nodejs.sh && \
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg > yarn.gpg.key && \
    /validate_file_hash 8550a7e298b523fffa899069754fc150f2ff74092701e4d4109edd1cd6d5327f  yarn.gpg.key && cat yarn.gpg.key | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get -y install gcc g++ make yarn && \
    # script is to have the latest available version of git-lfs
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash && \
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
    mkdir -p /usr/bin/strong_network_startup && \
    adduser --gecos '' --disabled-password developer && \
    echo 'developer ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/nopasswd && \
    # Change permissions of /usr/local
    chgrp -R developer /usr/local && \
    chmod -R g+w /usr/local && \
    mkdir -p /home/developer && \
    chown -R developer /home/developer && \
    chmod -R 770 /home/developer

COPY unzip_ide.sh /unzip_ide.sh
COPY --chown=developer:developer install_go_tools.sh /usr/bin/strong_network_startup/install_go_tools.sh

RUN chmod 4755 /usr/bin/strong_network_startup/install_go_tools.sh && chmod +x /unzip_ide.sh && chmod +x /usr/bin/strong_network_startup/install_go_tools.sh &&\
    curl -s https://get.sdkman.io > /tmp/install_sdkman.sh &&\
    cd /tmp &&\
    /validate_file_hash 570ce32b2b96863a82194bde22c28373b7af92cb688aec59ce269545885442f0 install_sdkman.sh &&\
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