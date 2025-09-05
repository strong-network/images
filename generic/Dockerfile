ARG BASE_IMAGE=sn_base
FROM ${BASE_IMAGE}


ENV GOPATH=/home/developer/go
ENV PATH=/usr/local/go/bin:/home/developer/go/bin:${PATH}
ENV GO111MODULE=on

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y rlwrap

RUN wget -O golang_sdk-linux-amd64.tar.gz https://go.dev/dl/go1.24.4.linux-amd64.tar.gz && \
    /validate_file_hash 77e5da33bb72aeaef1ba4418b6fe511bc4d041873cbf82e5aa6318740df98717 golang_sdk-linux-amd64.tar.gz && \
    tar -C /usr/local -xzf golang_sdk-linux-amd64.tar.gz && \
    rm golang_sdk-linux-amd64.tar.gz

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 2

# Install vscode deps
RUN curl -fsSOL http://http.us.debian.org/debian/pool/main/libo/libonig/libonig5_6.9.9-1+b1_amd64.deb && \
    /validate_file_hash 3abee130696244050500bcc7870e3b4cb82ddd87149ece3fd55010c3d4e1d18c libonig5_6.9.9-1+b1_amd64.deb && \
    dpkg -i libonig*.deb && \
    curl -fsSOL http://http.us.debian.org/debian/pool/main/j/jq/libjq1_1.8.1-3_amd64.deb && \
    /validate_file_hash 7236dd236b1d9d4c6c9ea7c100d25d65004196e281e3f85448018e94508d64a1 libjq1_1.8.1-3_amd64.deb && \
    dpkg -i libjq*.deb && \
    curl -fsSOL http://http.us.debian.org/debian/pool/main/j/jq/jq_1.8.1-3_amd64.deb && \
    /validate_file_hash 30bea2a1d2551a1fa91d74bf5784b1dfa7fc99deb37c1e2f8a2d1c9ab934d2e1 jq_1.8.1-3_amd64.deb && \
    dpkg -i jq*.deb && rm *.deb && \
    npm install -g npm && \
    curl -O https://download.clojure.org/install/linux-install-1.11.1.1224.sh && \
    /validate_file_hash 3bbab4d253eda43e3122fd5705014a69c44944a6dee8ea4d7d567afe157eb4ef linux-install-1.11.1.1224.sh && \
    chmod +x linux-install-1.11.1.1224.sh && \
    ./linux-install-1.11.1.1224.sh && rm -f linux-install-1.11.1.1224.sh

USER 1000

WORKDIR /home/developer