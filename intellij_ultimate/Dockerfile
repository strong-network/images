FROM sn_base

RUN  wget -O /ide.tar.gz https://download.jetbrains.com/idea/ideaIU-2022.1.1.tar.gz ;\
    /validate_file_hash 4291489cc15f62fa0c9ed338b94dba9889b23d8d8d6e00638fdcb4aab69eb0f5  ide.tar.gz ;\
    /unzip_ide.sh ;\
    DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get -y install php libapache2-mod-php maven gradle ;\
    rm -rf /var/lib/apt/lists/* ;\
    rm -rf /var/cache/apt ;\
    chown -R developer:developer /ide/bin

RUN chown -R developer:developer //usr/bin/strong_network_startup

USER developer
WORKDIR /home/developer

RUN curl -s https://get.sdkman.io > install_sdkman.sh ;\
    /validate_file_hash 97edfa3a9d73858a2bb5a3a4b64231e8e68e2b9b0a9f216f51ff1c523987fdc2  install_sdkman.sh ;\
    echo '#!/binbash\n\
    cat install_sdkman.sh | bash && source "$HOME/.sdkman/bin/sdkman-init.sh" && sdk install grails' > /usr/bin/strong_network_startup/add_sdk
