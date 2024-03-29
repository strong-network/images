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
RUN wget https://download.docker.com/linux/static/stable/x86_64/docker-20.10.24.tgz -O docker.tar.gz && \
    /validate_file_hash ab91092320a87691a1eaf0225b48585db9c69cff0ed4b0f569f744ff765515e3 docker.tar.gz && \
    tar -C /tmp -xzf docker.tar.gz && \
    rm docker.tar.gz && \
    mv /tmp/docker/docker /usr/bin/ && \
    rm -r /tmp/docker && \
    wget https://github.com/docker/compose/releases/download/v2.26.0/docker-compose-linux-x86_64 -O /usr/local/bin/docker-compose && \
    /validate_file_hash 59c6b262bedc4a02f46c8400e830e660935684899c770c3f5e804a2b7079fc16 /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    mkdir -p /usr/bin/strong_network_startup

# Install kubernetes related tools
RUN wget -O helm.tar.gz https://get.helm.sh/helm-v3.14.3-linux-amd64.tar.gz && \
    /validate_file_hash 3c90f24e180f8c207b8a18e5ec82cb0fa49858a7a0a86e4ed52a98398681e00b helm.tar.gz && \
    tar -C /tmp -xzf helm.tar.gz && \
    mv /tmp/linux-amd64/helm /usr/local/bin && \
    rm helm.tar.gz && \
    rm -r /tmp/linux-amd64 && \
    wget -O kubectl https://storage.googleapis.com/kubernetes-release/release/v1.29.3/bin/linux/amd64/kubectl && \
    /validate_file_hash 89c0435cec75278f84b62b848b8c0d3e15897d6947b6c59a49ddccd93d7312bf kubectl && \
    mv kubectl /usr/local/bin && \
    chmod 4755 /usr/local/bin/kubectl

# Install cloud specific CLI tools
RUN wget -O doctl.tar.gz https://github.com/digitalocean/doctl/releases/download/v1.104.0/doctl-1.104.0-linux-amd64.tar.gz && \
    /validate_file_hash f758b0c2fb7857db2bd00439155154f2ab8bee71c4f3640f90f64ec35256ca53 doctl.tar.gz && \
    tar -C /usr/local/bin -xzf doctl.tar.gz && \
    rm doctl.tar.gz && \
    # Install AWS cli
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.15.32.zip" -o "awscliv2.zip" && \
    /validate_file_hash e3e67df01ec76719a5880d7bfdb7d87822512784ce7ee60d86e9b9c110622d9a awscliv2.zip && \
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
    wget -O powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v7.4.1/powershell_7.4.1-1.deb_amd64.deb && \
    /validate_file_hash 625b7ee0b71147421723cb6022a41b5d8fc0d6e19df25b1240008ee491bf6997 powershell.tar.gz && \
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
    /validate_file_hash e931556f8c8a9e5b67bd6c0d378b5c1e3210bfe6466d6205164e919b66d4906a terrascan.tar.gz && \
    tar -xf terrascan.tar.gz terrascan && rm terrascan.tar.gz && \
    install terrascan /usr/local/bin && rm terrascan && \
    curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh > install_tflint.sh && \
    /validate_file_hash 3f435468083426b8161306ccb6bd267b1cc82045c205be330ae157a75251a87c install_tflint.sh && cat install_tflint.sh | bash && rm install_tflint.sh && \
    curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh > install_tfsec.sh && \
    /validate_file_hash c6621a5be84cdecc292cee9745470519dbc1cf38637525f4dc3310ea9101ec90 install_tfsec.sh && cat install_tfsec.sh | bash && rm install_tfsec.sh


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

RUN chmod 4755 /usr/bin/strong_network_startup/install_go_tools.sh && chmod +x /unzip_ide.sh && chmod +x /usr/bin/strong_network_startup/install_go_tools.sh &&\
    curl -s https://get.sdkman.io > /tmp/install_sdkman.sh &&\
    cd /tmp &&\
    /validate_file_hash 9be925ee0b858cf9df8dbdb028c30aca961c585b4835caef3d6350de3166779c install_sdkman.sh &&\
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