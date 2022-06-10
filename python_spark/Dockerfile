FROM sn_base

ENV DEFAULT_PORT 1111


COPY setup.sh /setup.sh
COPY install_python_spark.sh /install_python_spark.sh
COPY config.json /config.json
COPY kernel.json /kernel.json

RUN chmod +x /setup.sh && ./setup.sh && rm /setup.sh

USER developer
WORKDIR /home/developer
