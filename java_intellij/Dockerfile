FROM sn_base

RUN wget -O /ide.tar.gz https://download-cf.jetbrains.com/idea/ideaIC-2021.3.2.tar.gz && \
    /validate_file_hash 99e2225846d118e3190023abc65c8b2c62a1d1463f601c79a20b9494c54a08c9  ide.tar.gz && \
    /unzip_ide.sh && \
    chown -R developer:developer /ide/bin

RUN apt-get update && \
    apt-get install default-jdk -y && \
    wget -c https://services.gradle.org/distributions/gradle-7.6.1-bin.zip -P /tmp && \
    /validate_file_hash 6147605a23b4eff6c334927a86ff3508cb5d6722cd624c97ded4c2e8640f1f87 /tmp/gradle-7.6.1-bin.zip && \
    unzip -d /opt/gradle /tmp/gradle-7.6.1-bin.zip && \
    ln -s /opt/gradle/gradle-7.6.1 /opt/gradle/latest && \
    apt-get install -y maven && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt 

ENV GRADLE_HOME=/opt/gradle/gradle-7.6.1
ENV PATH=$PATH:$GRADLE_HOME/bin

USER developer
WORKDIR /home/developer