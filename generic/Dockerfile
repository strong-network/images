ARG BASE_IMAGE=sn_base
FROM ${BASE_IMAGE}


ENV GOPATH=/home/developer/go
ENV PATH=/usr/local/go/bin:/home/developer/go/bin:${PATH}
ENV GO111MODULE=on

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y rlwrap

RUN wget -O golang_sdk-linux-amd64.tar.gz https://go.dev/dl/go1.26.2.linux-amd64.tar.gz && \
    /validate_file_hash 990e6b4bbba816dc3ee129eaeaf4b42f17c2800b88a2166c265ac1a200262282 golang_sdk-linux-amd64.tar.gz && \
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
    curl -fsSL https://download.clojure.org/install/linux-install-1.12.4.1618.sh > linux-install-clojure.sh && \
    /validate_file_hash 8a49ab11a639ce1d49e5459a7bfa8fcc74684ad3bc9acd181e3adc7a662918cf linux-install-clojure.sh && \
    chmod +x linux-install-clojure.sh && \
    ./linux-install-clojure.sh && rm -f linux-install-clojure.sh

USER 1000

WORKDIR /home/developer
