FROM sn_base

RUN wget -O /ide.tar.gz https://download-cf.jetbrains.com/idea/ideaIC-2021.3.2.tar.gz ;\
    /validate_file_hash 99e2225846d118e3190023abc65c8b2c62a1d1463f601c79a20b9494c54a08c9  ide.tar.gz ;\
    /unzip_ide.sh ;\
    chown -R developer:developer /ide/bin

RUN apt-get install -y maven gradle ;\
    rm -rf /var/lib/apt/lists/* ;\
    rm -rf /var/cache/apt 

USER developer
WORKDIR /home/developer

RUN curl -s https://get.sdkman.io > install_sdkman.sh ;\
    /validate_file_hash 97edfa3a9d73858a2bb5a3a4b64231e8e68e2b9b0a9f216f51ff1c523987fdc2  install_sdkman.sh ;\
    export SDKMAN_DIR=/tmp/custom_installations && cat install_sdkman.sh | bash && bash -c "source /tmp/custom_installations/bin/sdkman-init.sh && sdk install grails"