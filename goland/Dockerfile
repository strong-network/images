FROM sn_base_jetbrains

COPY --chown=developer:developer setup.sh /setup.sh

ENV GOPATH=/home/developer/go
ENV PATH=/usr/local/go/bin:/home/developer/go/bin:${PATH}
ENV GO111MODULE=on

RUN chmod +x /setup.sh && /setup.sh && rm /setup.sh

USER developer

WORKDIR /home/developer