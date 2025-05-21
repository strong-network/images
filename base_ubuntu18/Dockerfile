FROM ubuntu:18.04

ENV SHELL=/bin/bash
ENV LANG=en_US.UTF-8
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# The minimum requirements to run a Strong Network workspace

RUN apt-get update && \
    apt-get install -y git locales sudo curl wget make build-essential gawk bison \
    libkrb5-dev libssl-dev && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && apt-get update && \
    DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get -y install git-lfs ssh && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata && \
    chsh -s /bin/bash && \
    sed -i 's/# en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && locale-gen && \
    mkdir -p /usr/bin/strong_network_startup && chmod 777 /usr/bin/strong_network_startup && \
    adduser --gecos '' --disabled-password developer && \
    # Change permissions of /usr/local
    chgrp -R developer /usr/local && \
    chmod -R g+w /usr/local && \
    echo 'developer ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/nopasswd 
    
# End of minimum requirements to run a Strong Network workspace
