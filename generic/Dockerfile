ARG BASE_IMAGE=sn_base
FROM ${BASE_IMAGE}


ENV GOPATH=/home/developer/go
ENV PATH=/usr/local/go/bin:/home/developer/go/bin:${PATH}
ENV GO111MODULE=on

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y rlwrap

RUN wget -O golang_sdk-linux-amd64.tar.gz https://go.dev/dl/go1.25.3.linux-amd64.tar.gz && \
    /validate_file_hash 0335f314b6e7bfe08c3d0cfaa7c19db961b7b99fb20be62b0a826c992ad14e0f golang_sdk-linux-amd64.tar.gz && \
    tar -C /usr/local -xzf golang_sdk-linux-amd64.tar.gz && \
    rm golang_sdk-linux-amd64.tar.gz

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 2

# Install vscode deps
RUN curl -fsSL http://http.us.debian.org/debian/pool/main/libo/libonig/libonig5_6.9.10-1_amd64.deb > libonig.deb && \
    /validate_file_hash c9c2d3745b8580d5e7ff3a0f114c673c9c4062c52993b51339e6f65d5cb0d08b libonig.deb && \
    dpkg -i libonig.deb && \
    curl -fsSL http://http.us.debian.org/debian/pool/main/j/jq/libjq1_1.8.1-4_amd64.deb > libjq.deb && \
    /validate_file_hash f3bf1249b0977503e3ab1eddde63051c0d603bde47a683c624aeaef20b36fad6 libjq.deb && \
    dpkg -i libjq.deb && \
    curl -fsSL http://http.us.debian.org/debian/pool/main/j/jq/jq_1.8.1-4_amd64.deb > jq.deb  && \
    /validate_file_hash ce96c71568bbe069b1500943d3c4d1c8785a5414f39ff47ec3fa1bfba14ec3ff jq.deb && \
    dpkg -i jq.deb && rm *.deb && \
    npm install -g npm && \
    curl -fsSL https://download.clojure.org/install/linux-install-1.12.3.1577.sh > linux-install-clojure.deb && \
    /validate_file_hash a55106244ca93ef7b61309e9dca4b248257685870824a8abe2efa706ede8241f linux-install-clojure.sh && \
    chmod +x linux-install-clojure.sh && \
    ./linux-install-clojure.sh && rm -f linux-install-clojure.sh

USER 1000

WORKDIR /home/developer