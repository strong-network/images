ARG BASE_IMAGE=sn_generic
FROM ${BASE_IMAGE}

USER 0

COPY install-claude.sh /tmp/install-claude.sh
RUN bash /tmp/install-claude.sh && rm /tmp/install-claude.sh

COPY setup-claude.sh /usr/bin/strong_network_startup/setup-claude.sh
RUN chmod +x /usr/bin/strong_network_startup/setup-claude.sh

WORKDIR /home/developer

USER 1000
