FROM centos:7

RUN yum -y update && yum install -y git locales sudo curl wget make build-essential gawk bison libkrb5-dev libssl-dev && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | bash && \
    yum install -y git-lfs ssh tzdata && \
    chsh -s /bin/bash && \
    #sed -i 's/# en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && locale-gen && \
    mkdir -p /usr/bin/strong_network_startup && chmod 777 /usr/bin/strong_network_startup && \
    adduser --password '' developer && \
    usermod -aG wheel developer && \
    # Disable the security warning
    su -c "sudo whoami" developer && \
    chgrp -R developer /usr/local && \
    chmod -R g+w /usr/local && \
    echo 'developer ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/nopasswd