ARG BASE_IMAGE=sn_base
FROM ${BASE_IMAGE}

ENV GOPATH=/home/developer/go
ENV PATH=/usr/local/go/bin:/home/developer/go/bin:${PATH}
ENV GO111MODULE=on

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y rlwrap

RUN wget -O golang_sdk-linux-amd64.tar.gz https://go.dev/dl/go1.26.10.linux-amd64.tar.gz && \
    /validate_file_hash ccfe7ae822d2c2f41f4fe7c956199967a4dac22d0ee0d2b2bfdb440aab3b20c5 golang_sdk-linux-amd64.tar.gz && \
    tar -C /usr/local -xzf golang_sdk-linux-amd64.tar.gz && \
    rm golang_sdk-linux-amd64.tar.gz

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 2

# jq 1.8.1 is installed as a static binary in the base image (see base/Dockerfile), so all
# base-derived images inherit it and the vulnerable distro jq packages are never installed.

RUN curl -fsSL https://www.npmjs.com/install.sh | sh && \
    npm install -g brace-expansion picomatch && \
    curl -fsSL https://download.clojure.org/install/linux-install-1.12.5.1645.sh > linux-install-clojure.sh && \
    /validate_file_hash 3d6e8428fd4c7f76de9f87f77b2347f293109f4e88fb20c154b3fa34a7f687dd linux-install-clojure.sh && \
    chmod +x linux-install-clojure.sh && \
    ./linux-install-clojure.sh && rm -f linux-install-clojure.sh

USER 1000

WORKDIR /home/developer
