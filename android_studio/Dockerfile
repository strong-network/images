FROM sn_base_jetbrains

COPY --chown=developer:developer setup.sh /setup.sh

RUN chmod +x /setup.sh && /setup.sh && rm /setup.sh

USER developer

WORKDIR /home/developer