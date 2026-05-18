ARG BASE_IMAGE=sn_base
FROM ${BASE_IMAGE}


ENV GOPATH=/home/developer/go
ENV PATH=/usr/local/go/bin:/home/developer/go/bin:${PATH}
ENV GO111MODULE=on

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y rlwrap

RUN wget -O golang_sdk-linux-amd64.tar.gz https://go.dev/dl/go1.26.3.linux-amd64.tar.gz && \
    /validate_file_hash 2b2cfc7148493da5e73981bffbf3353af381d5f93e789c82c79aff64962eb556 golang_sdk-linux-amd64.tar.gz && \
    tar -C /usr/local -xzf golang_sdk-linux-amd64.tar.gz && \
    rm golang_sdk-linux-amd64.tar.gz

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 2

# Install jq 1.8.1 as a static binary from GitHub releases.
# Previously, jq was installed via dpkg by manually chaining libonig5 -> libjq1 -> jq .deb packages
# from http.us.debian.org (dpkg does not auto-resolve deps like apt). Those mirror URLs are no longer
# reliable. The static jq-linux64 binary bundles oniguruma internally and has no runtime dependency
# on libonig5 or libjq1, so neither library package is required. No other component in this image
# depends on them either.
RUN curl -fsSL https://github.com/jqlang/jq/releases/download/jq-1.8.1/jq-linux64 -o /usr/local/bin/jq && \
    /validate_file_hash 020468de7539ce70ef1bceaf7cde2e8c4f2ca6c3afb84642aabc5c97d9fc2a0d /usr/local/bin/jq && \
    chmod +x /usr/local/bin/jq

RUN curl -fsSL https://www.npmjs.com/install.sh | sh && \
    npm install -g brace-expansion picomatch && \
    curl -fsSL https://download.clojure.org/install/linux-install-1.12.5.1645.sh > linux-install-clojure.sh && \
    /validate_file_hash 3d6e8428fd4c7f76de9f87f77b2347f293109f4e88fb20c154b3fa34a7f687dd linux-install-clojure.sh && \
    chmod +x linux-install-clojure.sh && \
    ./linux-install-clojure.sh && rm -f linux-install-clojure.sh

USER 1000

WORKDIR /home/developer
