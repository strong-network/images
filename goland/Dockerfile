FROM sn_base

ENV GOPATH=/home/developer/go
ENV PATH=/usr/local/go/bin:/home/developer/go/bin:${PATH}
ENV GO111MODULE=on

RUN wget -O /ide.tar.gz https://download.jetbrains.com/go/goland-2022.3.tar.gz ;\
    /validate_file_hash 4bda4567e199704d8fa65f1a4544404ac53bcd74ea189d8a0dddc5674c85d93a  ide.tar.gz ;\
    /unzip_ide.sh ;\
    chown -R developer:developer /ide/bin


RUN npm install -g npm-check-updates ;\
    npm install -g handlebars diff ;\
    wget -O golang_sdk-linux-amd64.tar.gz https://go.dev/dl/go1.19.6.linux-amd64.tar.gz ;\
    /validate_file_hash e3410c676ced327aec928303fef11385702a5562fd19d9a1750d5a2979763c3d  golang_sdk-linux-amd64.tar.gz ;\
    tar -C /usr/local -xzf golang_sdk-linux-amd64.tar.gz ;\
    rm golang_sdk-linux-amd64.tar.gz ;\
    rm -rf /var/lib/apt/lists/* ;\
    rm -rf /var/cache/apt
    

USER developer

WORKDIR /home/developer