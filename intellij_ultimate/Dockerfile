FROM sn_base

RUN wget -O /ide.tar.gz https://download.jetbrains.com/idea/ideaIU-2022.1.1.tar.gz && \
    /validate_file_hash 4291489cc15f62fa0c9ed338b94dba9889b23d8d8d6e00638fdcb4aab69eb0f5  ide.tar.gz && \
    /unzip_ide.sh && \
    chown -R developer:developer /ide/bin

RUN wget -c https://services.gradle.org/distributions/gradle-7.6.1-bin.zip -P /tmp && \
    unzip -d /opt/gradle /tmp/gradle-7.6.1-bin.zip && \
    ln -s /opt/gradle/gradle-7.6.1 /opt/gradle/latest && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get -y install php libapache2-mod-php maven && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt

RUN chown -R developer:developer //usr/bin/strong_network_startup

USER developer
WORKDIR /home/developer
