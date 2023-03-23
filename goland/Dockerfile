FROM sn_base

ENV GOPATH=/home/developer/go
ENV PATH=/usr/local/go/bin:/home/developer/go/bin:${PATH}
ENV GO111MODULE=on

RUN wget -O /ide.tar.gz https://download.jetbrains.com/go/goland-2022.3.3.tar.gz && \
    /validate_file_hash 8c85b56b4e226739a0e36549f5f80fed4cbf2b2798eff442499f5779396a6917 ide.tar.gz && \
    /unzip_ide.sh && \
    chown -R developer:developer /ide/bin

RUN npm install -g npm-check-updates && \
    npm install -g handlebars diff && \
    wget -O golang_sdk-linux-amd64.tar.gz https://go.dev/dl/go1.20.2.linux-amd64.tar.gz && \
    /validate_file_hash 4eaea32f59cde4dc635fbc42161031d13e1c780b87097f4b4234cfce671f1768 golang_sdk-linux-amd64.tar.gz && \
    tar -C /usr/local -xzf golang_sdk-linux-amd64.tar.gz && \
    rm golang_sdk-linux-amd64.tar.gz && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt
    

USER developer

WORKDIR /home/developer