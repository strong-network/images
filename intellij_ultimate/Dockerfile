FROM sn_base

RUN wget -O /ide.tar.gz https://download.jetbrains.com/idea/ideaIU-2022.1.4.tar.gz && \
    /validate_file_hash f9e9389f0184306cae8d8b464a7c9b5baabb3a10a526a76fa7f0e3b44a158b8d  ide.tar.gz && \
    /unzip_ide.sh && \
    chown -R developer:developer /ide/bin

RUN wget -c https://services.gradle.org/distributions/gradle-7.6.1-bin.zip -P /tmp && \
    /validate_file_hash 6147605a23b4eff6c334927a86ff3508cb5d6722cd624c97ded4c2e8640f1f87 /tmp/gradle-7.6.1-bin.zip && \
    unzip -d /opt/gradle /tmp/gradle-7.6.1-bin.zip && \
    ln -s /opt/gradle/gradle-7.6.1 /opt/gradle/latest && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get -y install php libapache2-mod-php maven && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt

RUN chown -R developer:developer //usr/bin/strong_network_startup

ENV GRADLE_HOME=/opt/gradle/gradle-7.6.1
ENV PATH=$PATH:$GRADLE_HOME/bin

USER developer
WORKDIR /home/developer
