FROM sn_base

RUN wget -O /ide.tar.gz https://download.jetbrains.com/webstorm/WebStorm-2022.2.3.tar.gz ;\
    /validate_file_hash 1d7d464bbcb83d5af48359aeda6aa7d165038bfaa1f26fef1019761eb278fa22  ide.tar.gz ;\
    /unzip_ide.sh ;\
    chown -R developer:developer /ide/bin

RUN curl -fsSL https://deb.nodesource.com/setup_18.x > node_setup.sh ;\
    /validate_file_hash curl -fsSL https://deb.nodesource.com/setup_18.x > node_setup.sh && cat node_setup.sh | bash - && rm node_setup.sh ;\
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg > yarn.gpg.key ;\
    /validate_file_hash 8550a7e298b523fffa899069754fc150f2ff74092701e4d4109edd1cd6d5327f  yarn.gpg.key && cat yarn.gpg.key | apt-key add - && rm yarn.gpg.key ;\
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list ;\
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh > install_nvm.sh ;\
    /validate_file_hash 2ed5e94ba12434370f0358800deb69f514e8bce90f13beb0e1b241d42c6abafd  install_nvm.sh && cat install_nvm.sh | bash && rm install_nvm.sh ;\
    export NVM_DIR="$HOME/.nvm" ;\
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" ;\ 
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" ;\ 
    nvm install 18.10.0 ;\
    nvm use 18.10.0 ;\
    wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb ;\
    /validate_file_hashb8713c36d3e6f6b2520830180cf6b5779e48410ad5d5e1b192635b0c7359fcc6  packages-microsoft-prod.deb ;\
    dpkg -i packages-microsoft-prod.deb ;\
    rm packages-microsoft-prod.deb ;\
    apt-get update && apt-get install -y dotnet-sdk-7.0 ;\
    DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get install php libapache2-mod-php -y ;\
    # clean apt to reduce image size
    rm -rf /var/lib/apt/lists/* ;\
    rm -rf /var/cache/apt 
    # change permissions

USER developer

WORKDIR /home/developer