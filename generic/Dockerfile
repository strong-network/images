FROM strong_network_base

ENV GOPATH /home/developer/go/bin
ENV PATH /usr/local/go/bin:/home/developer/go/bin:${PATH}
ENV GO111MODULE  on

COPY --chown=developer:developer setup.sh /setup.sh
COPY --chown=developer:developer install_go_tools.sh /install_go_tools.sh
COPY --chown=developer:developer install_nodejs_tools.sh /install_nodejs_tools.sh

RUN chmod +x setup.sh && /setup.sh && rm setup.sh

USER 1000

WORKDIR /home/developer