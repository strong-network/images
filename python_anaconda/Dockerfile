FROM sn_base

ENV DEFAULT_PORT 1111

COPY --chown=developer:developer  setup.sh /setup.sh
COPY --chown=developer:developer install_python_anaconda.sh /install_python_anaconda.sh

RUN chmod +x /setup.sh && /setup.sh && rm /setup.sh

USER developer

WORKDIR /home/developer