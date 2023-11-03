#
# Sysbox base image is built on top of our base image
# Provides docker, minikube and neccessary tools installed in order to run them.
#

FROM sn_base

RUN apt-get update      &&  \
    apt-get install -y      \
    wget                    \
    iptables                \
    iproute2

# Install Docker and it's missing tools
RUN wget https://download.docker.com/linux/static/stable/x86_64/docker-24.0.6.tgz -O docker.tar.gz      &&  \
    /validate_file_hash 99792dec613df93169a118b05312a722a63604b868e4c941b1b436abcf3bb70f docker.tar.gz  &&  \
    tar -C /tmp -xzf docker.tar.gz                                                                      &&  \
    rm docker.tar.gz                                                                                    &&  \
    mv /tmp/docker/* /usr/bin/                                                                          


# Add user developer to docker group
RUN groupadd docker                 &&  \
    usermod -aG docker developer    &&  \
    newgrp docker                   
	

# Install minikube
RUN curl -LO https://storage.googleapis.com/minikube/releases/v1.30.1/minikube-linux-amd64  &&  \
    install minikube-linux-amd64 /usr/local/bin/minikube
