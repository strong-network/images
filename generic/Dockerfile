ARG BASE_IMAGE=sn_base
FROM ${BASE_IMAGE}


ENV GOPATH=/home/developer/go
ENV PATH=/usr/local/go/bin:/home/developer/go/bin:${PATH}
ENV GO111MODULE=on

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y rlwrap

RUN wget -O golang_sdk-linux-amd64.tar.gz https://go.dev/dl/go1.25.9.linux-amd64.tar.gz && \
    /validate_file_hash 00859d7bd6defe8bf84d9db9e57b9a4467b2887c18cd93ae7460e713db774bc1 golang_sdk-linux-amd64.tar.gz && \
    tar -C /usr/local -xzf golang_sdk-linux-amd64.tar.gz && \
    rm golang_sdk-linux-amd64.tar.gz

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 2

# Install vscode deps
RUN curl -fsSL http://http.us.debian.org/debian/pool/main/libo/libonig/libonig5_6.9.10-1_amd64.deb > libonig.deb && \
    /validate_file_hash c9c2d3745b8580d5e7ff3a0f114c673c9c4062c52993b51339e6f65d5cb0d08b libonig.deb && \
    dpkg -i libonig.deb && \
    curl -fsSL http://http.us.debian.org/debian/pool/main/j/jq/libjq1_1.8.1-4+b1_amd64.deb > libjq.deb && \
    /validate_file_hash 72587db03a2cd41e0147f5d73dfccdf3111a66fa9cd7b1fd9965bed7e61318fd libjq.deb && \
    dpkg -i libjq.deb && \
    curl -fsSL http://http.us.debian.org/debian/pool/main/j/jq/jq_1.8.1-4+b1_amd64.deb > jq.deb  && \
    /validate_file_hash 90897b56cd86c21f8c1c98687cf185ddfa52add5a0bae7b894fe863f45fd34c5 jq.deb && \
    dpkg -i jq.deb && rm *.deb && \
    curl -fsSL https://www.npmjs.com/install.sh | sh && \
    npm update brace-expansion picomatch && \
    curl -fsSL https://download.clojure.org/install/linux-install-1.12.4.1618.sh > linux-install-clojure.sh && \
    /validate_file_hash 8a49ab11a639ce1d49e5459a7bfa8fcc74684ad3bc9acd181e3adc7a662918cf linux-install-clojure.sh && \
    chmod +x linux-install-clojure.sh && \
    ./linux-install-clojure.sh && rm -f linux-install-clojure.sh

USER 1000

WORKDIR /home/developer
