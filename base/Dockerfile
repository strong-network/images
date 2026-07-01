# Build stage: compile git-lfs from source using Go 1.26.4.
# CGO_ENABLED=0 produces a fully static binary with no runtime dependencies.
# Using a separate build stage ensures the Go toolchain (~500MB) never appears in the final image.
FROM golang:1.26.4 AS git-lfs-builder
RUN GIT_LFS_COMMIT="0a45b99f9fa8d1942cc44f089029a031805461f1" && \
    curl -fsSL "https://github.com/git-lfs/git-lfs/archive/${GIT_LFS_COMMIT}.tar.gz" -o /tmp/git-lfs-src.tar.gz && \
    tar -xzf /tmp/git-lfs-src.tar.gz -C /tmp && \
    cd "/tmp/git-lfs-${GIT_LFS_COMMIT}" && \
    # Bump vulnerable transitive deps before building:
    go get golang.org/x/crypto@v0.52.0 golang.org/x/net@v0.55.0 && \
    go mod tidy && \
    CGO_ENABLED=0 go build -o /usr/local/bin/git-lfs .

FROM ubuntu:24.04

# Copy the git-lfs binary compiled in the build stage above
COPY --from=git-lfs-builder /usr/local/bin/git-lfs /usr/local/bin/git-lfs

ENV SHELL=/bin/bash
ENV LANG=en_US.UTF-8
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# The minimum requirements to run a Strong Network workspace
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y --no-install-recommends git && \
    apt-get install -y locales sudo curl \
    libkrb5-dev libssl-dev && \
    DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get -y install ssh && \
    git lfs install && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata && \
    chsh -s /bin/bash && \
    sed -i 's/# en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && locale-gen && \
    mkdir -p /usr/bin/strong_network_startup && chmod 777 /usr/bin/strong_network_startup && \
    usermod -u 2000 ubuntu && groupmod -g 2000 ubuntu && \
    adduser --gecos '' --disabled-password developer && \
    # Change permissions of /usr/local
    chgrp -R developer /usr/local && \
    chmod -R g+w /usr/local && \
    echo 'developer ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/nopasswd && \
    rm -rf /var/lib/apt/lists/*
# End of minimum requirements to run a Strong Network workspace

COPY validate_file_hash.sh /validate_file_hash

# Install user space packages
RUN apt-get update && \
    apt-get install -y wget python3-dev python3-pip python3-venv software-properties-common libffi-dev nano tmux vim emacs asciinema \
    build-essential clang-format clang libsecret-1-dev libx11-dev libxkbfile-dev gettext-base rsync libxext6 libxrender1 libxtst6 unzip \
    libxi6 libfreetype6 dirmngr lsb-release less && \
    mkdir -p /usr/bin/strong_network_startup/vscode_extensions && chmod 777 /usr/bin/strong_network_startup/vscode_extensions && \
    chown 1000:1000 /usr/bin/strong_network_startup/vscode_extensions && \
    mkdir -p /home/developer && \
    chown -R developer /home/developer && \
    chmod -R 770 /home/developer && \
    rm -rf /var/lib/apt/lists/*

# Download docker tools
RUN chmod +x /validate_file_hash && wget https://download.docker.com/linux/static/stable/x86_64/docker-29.6.1.tgz -O docker.tar.gz && \
    /validate_file_hash b0df4a43a98d7ecb708acbdb5a34a3416e13b6e39bcbbdf296f51f0f3442b29f docker.tar.gz && \
    tar -C /tmp -xzf docker.tar.gz && \
    rm docker.tar.gz && \
    mv /tmp/docker/docker /usr/bin/ && \
    rm -r /tmp/docker && \
    mkdir -p /usr/local/lib/docker/cli-plugins && \
    wget https://github.com/docker/buildx/releases/download/v0.35.0/buildx-v0.35.0.linux-amd64 -O /usr/local/lib/docker/cli-plugins/docker-buildx  && \
    /validate_file_hash d41ece72044243b4f58b343441ae37446d9c29a7d6b5e11c61847bbcf8f7dfda /usr/local/lib/docker/cli-plugins/docker-buildx && \
    chmod +x /usr/local/lib/docker/cli-plugins/docker-buildx && \
    wget https://github.com/docker/compose/releases/download/v5.2.0/docker-compose-linux-x86_64 -O /usr/local/bin/docker-compose && \
    /validate_file_hash 018f9612ecabc5f2d7aaa53d6f5f44453a87611e2d72c8ef84d7b1eca070e719 /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    mkdir -p /usr/bin/strong_network_startup

# Install kubernetes related tools
RUN wget -O helm.tar.gz https://get.helm.sh/helm-v4.2.2-linux-amd64.tar.gz && \
    /validate_file_hash 9adafecab4d406853bba163a70e9f104f47dbbf65ce24b7653bae7e36150bcb6 helm.tar.gz && \
    tar -C /tmp -xzf helm.tar.gz && \
    mv /tmp/linux-amd64/helm /usr/local/bin && \
    rm helm.tar.gz && \
    rm -r /tmp/linux-amd64 && \
    wget -O kubectl https://dl.k8s.io/release/v1.36.2/bin/linux/amd64/kubectl && \
    /validate_file_hash 1e9045ec32bea85da43de85f0065358529ea7c7a152eca78154fba5b58c27d82 kubectl && \
    mv kubectl /usr/local/bin && \
    chmod 4755 /usr/local/bin/kubectl

# Install jq 1.8.1 as a static binary from GitHub releases.
# The static jq-linux64 binary bundles oniguruma internally and has no runtime dependency on the
# distro libonig5/libjq1 packages, which carry unfixed CVEs. /usr/local/bin precedes /usr/bin on
# PATH, so this replaces the distro jq for all base-derived images.
RUN curl -fsSL https://github.com/jqlang/jq/releases/download/jq-1.8.1/jq-linux64 -o /usr/local/bin/jq && \
    /validate_file_hash 020468de7539ce70ef1bceaf7cde2e8c4f2ca6c3afb84642aabc5c97d9fc2a0d /usr/local/bin/jq && \
    chmod +x /usr/local/bin/jq

# Install cloud specific CLI tools
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.33.6.zip" -o "awscliv2.zip" && \
    /validate_file_hash e27a9d9b07429099dd641ed2b3b6664b41ff9471c426e8323c076ba87d215210 awscliv2.zip && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm awscliv2.zip && \
    rm -rf aws && \
    # Remove bundled vulnerable wheel package from AWS CLI (CVE-2026-24049)
    find /usr/local/aws-cli -name 'wheel*.dist-info' -type d -exec rm -rf {} + 2>/dev/null || true

# Install Azure CLI
RUN mkdir -p /etc/apt/keyrings && \
    curl -sLS https://packages.microsoft.com/keys/microsoft.asc > microsoft.asc && \
    cat microsoft.asc | gpg --dearmor | tee /etc/apt/keyrings/microsoft.gpg > /dev/null && \
    chmod go+r /etc/apt/keyrings/microsoft.gpg && \
    /validate_file_hash 098f10efd65c0d0a856a980144b5f37c05374eaa575a208d46913fd8f7eae951  /etc/apt/keyrings/microsoft.gpg && \
    AZ_REPO=$(lsb_release -cs) && \
    echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | tee /etc/apt/sources.list.d/azure-cli.list && \
    apt-get update && \
    apt-get install -y azure-cli && \
    rm -f /etc/apt/sources.list.d/azure-cli.list && \
    rm -rf /var/lib/apt/lists/*

# Install hashicorp/terraform tools
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg > hashicorp.key && \
    /validate_file_hash cafb01beac341bf2a9ba89793e6dd2468110291adfbb6c62ed11a0cde6c09029 hashicorp.key && \
    gpg --dearmor -o /etc/apt/keyrings/hashicorp.gpg hashicorp.key && \
    chmod go+r /etc/apt/keyrings/hashicorp.gpg && \
    rm hashicorp.key && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -y terraform && \
    rm -rf /var/lib/apt/lists/*


# Setup environment for developers
    # install general packages related to development

RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && apt-get install nodejs -y && \
    corepack enable && corepack prepare yarn@stable --activate && \
    apt-get -y install gcc g++ make && \
    apt-get install -y htop \
    zsh zip shellcheck tree \
    nodejs openjdk-11-jdk \
    # install networking related packages
    ca-certificates apt-transport-https dnsutils gnupg2 httpie inetutils-ping inetutils-tools inetutils-traceroute net-tools && \
    apt-get update && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt

COPY unzip_ide.sh /unzip_ide.sh
COPY --chown=developer:developer install_go_tools.sh /usr/bin/strong_network_startup/install_go_tools.sh

RUN chmod 4755 /usr/bin/strong_network_startup/install_go_tools.sh && chmod +x /unzip_ide.sh
