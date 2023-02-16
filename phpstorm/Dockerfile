FROM sn_base

COPY --chown=developer:developer setup.sh /setup.sh

RUN chmod +x /setup.sh && /setup.sh && rm /setup.sh

USER developer

WORKDIR /home/developer