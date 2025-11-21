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

# Install user space packages
RUN apt-get install -y wget python3-dev python3-pip python3-venv software-properties-common libffi-dev nano tmux vim emacs asciinema \
    build-essential clang-format clang libsecret-1-dev libx11-dev libxkbfile-dev gettext-base rsync libxext6 libxrender1 libxtst6 unzip \
    libxi6 libfreetype6 dirmngr lsb-release less && \
    mkdir -p /usr/bin/strong_network_startup/vscode_extensions && chmod 777 /usr/bin/strong_network_startup/vscode_extensions && \
    chown 1000:1000 /usr/bin/strong_network_startup/vscode_extensions && \
    mkdir -p /home/developer && \
    chown -R developer /home/developer && \
    chmod -R 770 /home/developer

# Install uv Python package manager
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Download docker tools
RUN chmod +x /validate_file_hash && wget https://download.docker.com/linux/static/stable/x86_64/docker-29.0.2.tgz -O docker.tar.gz && \
    /validate_file_hash 079e491e942e7a7a090c593db7eb63f3d657b5ca166c38dab59678b165b91eca docker.tar.gz && \
    tar -C /tmp -xzf docker.tar.gz && \
    rm docker.tar.gz && \
    mv /tmp/docker/docker /usr/bin/ && \
    rm -r /tmp/docker && \
    mkdir -p /usr/local/lib/docker/cli-plugins && \
    wget https://github.com/docker/buildx/releases/download/v0.30.1/buildx-v0.30.1.linux-amd64 -O /usr/local/lib/docker/cli-plugins/docker-buildx  && \
    /validate_file_hash c37114fcd034025ec68e224657c8a5a850df472ded3ddcbca75ad3a7ebb9710d /usr/local/lib/docker/cli-plugins/docker-buildx && \
    chmod +x /usr/local/lib/docker/cli-plugins/docker-buildx && \
    wget https://github.com/docker/compose/releases/download/v2.40.3/docker-compose-linux-x86_64 -O /usr/local/bin/docker-compose && \
    /validate_file_hash dba9d98e1ba5bfe11d88c99b9bd32fc4a0624a30fafe68eea34d61a3e42fd372 /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    mkdir -p /usr/bin/strong_network_startup

# Install kubernetes related tools
RUN wget -O helm.tar.gz https://get.helm.sh/helm-v4.0.0-linux-amd64.tar.gz && \
    /validate_file_hash c77e9e7c1cc96e066bd240d190d1beed9a6b08060b2043ef0862c4f865eca08f helm.tar.gz && \
    tar -C /tmp -xzf helm.tar.gz && \
    mv /tmp/linux-amd64/helm /usr/local/bin && \
    rm helm.tar.gz && \
    rm -r /tmp/linux-amd64 && \
    wget -O kubectl https://dl.k8s.io/release/v1.34.2/bin/linux/amd64/kubectl && \
    /validate_file_hash 9591f3d75e1581f3f7392e6ad119aab2f28ae7d6c6e083dc5d22469667f27253 kubectl && \
    mv kubectl /usr/local/bin && \
    chmod 4755 /usr/local/bin/kubectl

# Install cloud specific CLI tools
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.32.1.zip" -o "awscliv2.zip" && \
    /validate_file_hash 7be410c23d191e39c898cdd0cca7795de3a7c230631b1076246a3017ecfcd42e awscliv2.zip && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm awscliv2.zip && \
    rm -rf aws

# Install  Azure CLi
RUN mkdir -p /etc/apt/keyrings && \
    curl -sLS https://packages.microsoft.com/keys/microsoft.asc > microsoft.asc && \
    cat microsoft.asc | gpg --dearmor | tee /etc/apt/keyrings/microsoft.gpg > /dev/null && \
    chmod go+r /etc/apt/keyrings/microsoft.gpg && \
    /validate_file_hash 098f10efd65c0d0a856a980144b5f37c05374eaa575a208d46913fd8f7eae951  /etc/apt/keyrings/microsoft.gpg && \
    AZ_REPO=$(lsb_release -cs) && \
    echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | tee /etc/apt/sources.list.d/azure-cli.list && \
    apt-get update && \
    apt-get install -y azure-cli && \
    rm -rf /etc/apt/sources.list.d/azure-cl.list && \
    apt-get update

# Install hashcorp/terraform tools
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg > hashicorp.key && \
    /validate_file_hash cafb01beac341bf2a9ba89793e6dd2468110291adfbb6c62ed11a0cde6c09029 hashicorp.key && \
    cat hashicorp.key | apt-key add - && \
    rm hashicorp.key && \
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt-get update && \
    apt-get install terraform -y


# Setup environment for developers
    # install general packages related to development
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && apt-get install nodejs -y && \
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg > yarn.gpg.key && \
    /validate_file_hash 8550a7e298b523fffa899069754fc150f2ff74092701e4d4109edd1cd6d5327f  yarn.gpg.key && cat yarn.gpg.key | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get -y install gcc g++ make yarn && \
    # script is to have the latest available version of git-lfs
    apt-get install -y htop \
    zsh jq zip shellcheck tree \
    nodejs openjdk-11-jdk \
    # install networking related packages
    ca-certificates apt-transport-https dnsutils gnupg2 httpie inetutils-ping inetutils-tools inetutils-traceroute net-tools && \
    apt-get update && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt

COPY unzip_ide.sh /unzip_ide.sh
COPY --chown=developer:developer install_go_tools.sh /usr/bin/strong_network_startup/install_go_tools.sh

RUN chmod 4755 /usr/bin/strong_network_startup/install_go_tools.sh && chmod +x /unzip_ide.sh && chmod +x /usr/bin/strong_network_startup/install_go_tools.sh