FROM sn_base_jetbrains

COPY setup.sh /setup.sh

RUN chmod +x /setup.sh && ./setup.sh && rm /setup.sh

USER developer
WORKDIR /home/developer