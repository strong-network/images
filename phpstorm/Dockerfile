FROM sn_base

RUN wget -O /ide.tar.gz https://download-cf.jetbrains.com/webide/PhpStorm-2021.3.2.tar.gz && \
    /validate_file_hash 761b347142035e8b74cc5a9939100af9d45f1f6ee29de1e78cd6b1ff06fe20e2  ide.tar.gz && \
    /unzip_ide.sh && \
    chown -R developer:developer /ide/bin

RUN DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get install php libapache2-mod-php -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt

USER developer

WORKDIR /home/developer