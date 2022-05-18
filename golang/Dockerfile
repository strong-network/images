FROM strong_network_base 

ENV GOPATH /home/developer/go/bin
ENV PATH /usr/local/go/bin:/home/developer/go/bin:${PATH}
ENV GO111MODULE  on
ENV DEFAULT_PORT 1111

EXPOSE 1111

COPY setup.sh /setup.sh
COPY install_go_tools.sh /install_go_tools.sh

RUN chmod +x /setup.sh && ./setup.sh && rm /setup.sh

USER developer
WORKDIR /home/developer
