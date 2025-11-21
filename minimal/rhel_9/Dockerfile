FROM redhat/ubi9

ENV SHELL=/bin/bash
ENV LANG=en_US.UTF-8
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# The minimum requirements to run a Strong Network workspace
RUN yum update -y && \
    yum install -y git sudo openssl-devel util-linux-user && \
    yum update -y && \
    DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true yum -y install git-lfs openssh-clients openssh && \
    chsh -s /bin/bash && \
    sed -i 's/# LC_ALL=en_US.UTF-8/LC_CTYPE=en_US.UTF-8/' /etc/environment && \
    mkdir -p /usr/bin/strong_network_startup && chmod 777 /usr/bin/strong_network_startup && \
    # usermod -u 2000 ubuntu && groupmod -g 2000 ubuntu && \
    adduser developer && \
    # Change permissions of /usr/local
    chgrp -R developer /usr/local && \
    chmod -R g+w /usr/local && \
    echo 'developer ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/nopasswd
# End of minimum requirements to run a Strong Network workspace

COPY validate_file_hash.sh /validate_file_hash

# Optional Install user space packages
RUN yum install -y wget python3 python3-pip nano vim clang rsync unzip dirmngr less && \
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

USER 1000
WORKDIR /home/developer