FROM sn_base

RUN wget -O /ide.tar.gz https://download-cf.jetbrains.com/idea/ideaIC-2021.3.2.tar.gz ;\
    /validate_file_hash 99e2225846d118e3190023abc65c8b2c62a1d1463f601c79a20b9494c54a08c9  ide.tar.gz ;\
    /unzip_ide.sh ;\
    chown -R developer:developer /ide/bin

RUN apt-get update ;\
    apt-get install -y maven gradle ;\
    rm -rf /var/lib/apt/lists/* ;\
    rm -rf /var/cache/apt 

USER developer
WORKDIR /home/developer