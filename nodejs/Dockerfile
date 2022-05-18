FROM strong_network_base

COPY --chown=developer:developer setup.sh /setup.sh
COPY --chown=developer:developer install_nodejs_tools.sh /install_nodejs_tools.sh

RUN chmod +x /setup.sh && /setup.sh && rm /setup.sh

USER 1000

WORKDIR /home/developer