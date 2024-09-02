FROM sn_base

ENV GOPATH=/home/developer/go
ENV PATH=/usr/local/go/bin:/home/developer/go/bin:${PATH}
ENV GO111MODULE=on

RUN wget -O /ide.tar.gz https://download.jetbrains.com/go/goland-2021.3.5.tar.gz && \
    /validate_file_hash c369f984712da159d4105380fbd7735b575de9192c729ea8e985c992d2332b37 ide.tar.gz && \
    /unzip_ide.sh && \
    chown -R developer:developer /ide/bin

RUN npm install -g npm-check-updates && \
    npm install -g handlebars diff && \
    wget -O golang_sdk-linux-amd64.tar.gz https://go.dev/dl/go1.22.3.linux-amd64.tar.gz && \
    /validate_file_hash 8920ea521bad8f6b7bc377b4824982e011c19af27df88a815e3586ea895f1b36 golang_sdk-linux-amd64.tar.gz && \
    tar -C /usr/local -xzf golang_sdk-linux-amd64.tar.gz && \
    rm golang_sdk-linux-amd64.tar.gz && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt
    

USER developer

WORKDIR /home/developer