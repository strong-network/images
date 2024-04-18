ARG BASE_IMAGE=sn_base
FROM ${BASE_IMAGE}


ENV GOPATH /home/developer/go
ENV PATH /usr/local/go/bin:/home/developer/go/bin:${PATH}
ENV GO111MODULE on

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y rlwrap && \
    wget -O golang_sdk-linux-amd64.tar.gz https://go.dev/dl/go1.22.1.linux-amd64.tar.gz && \
    /validate_file_hash aab8e15785c997ae20f9c88422ee35d962c4562212bb0f879d052a35c8307c7f golang_sdk-linux-amd64.tar.gz && \
    tar -C /usr/local -xzf golang_sdk-linux-amd64.tar.gz && \
    rm golang_sdk-linux-amd64.tar.gz && \
    # Install vscode deps
    update-alternatives --install /usr/bin/python python /usr/bin/python2 1 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 2 && \
    curl -fsSOL http://http.us.debian.org/debian/pool/main/libo/libonig/libonig5_6.9.1-1_amd64.deb && \
    /validate_file_hash 0e34268dcb8d037d88d038030e61c89ee7f6d0923ba828574b8acddc19519ff3 libonig5_6.9.1-1_amd64.deb && \
    dpkg -i libonig*.deb && \
    curl -fsSOL http://http.us.debian.org/debian/pool/main/j/jq/libjq1_1.5+dfsg-2+b1_amd64.deb && \
    /validate_file_hash 73e222c0920988301d973be4649210f1af37bacee66176353ca1d312ef76cd67 libjq1_1.5+dfsg-2+b1_amd64.deb && \
    dpkg -i libjq*.deb && \
    curl -fsSOL http://http.us.debian.org/debian/pool/main/j/jq/jq_1.5+dfsg-2+b1_amd64.deb && \
    /validate_file_hash 2ec640d5280101e70b6da3df254e06c10117d7baefdc3878af64e1b0f072fec5 jq_1.5+dfsg-2+b1_amd64.deb && \
    dpkg -i jq*.deb && rm *.deb && \
    npm install -g npm && \
    curl -O https://download.clojure.org/install/linux-install-1.11.1.1224.sh && \
    /validate_file_hash 3bbab4d253eda43e3122fd5705014a69c44944a6dee8ea4d7d567afe157eb4ef linux-install-1.11.1.1224.sh && \ 
    chmod +x linux-install-1.11.1.1224.sh && \
    ./linux-install-1.11.1.1224.sh ; rm -f linux-install-1.11.1.1224.sh

USER 1000

WORKDIR /home/developer