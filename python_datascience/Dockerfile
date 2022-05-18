FROM strong_network_base

ENV DEFAULT_PORT 1111

COPY setup.sh /setup.sh

COPY install_python_datascience.sh /install_python_datascience.sh

RUN chmod +x /setup.sh && ./setup.sh && rm /setup.sh

USER developer
WORKDIR /home/developer

