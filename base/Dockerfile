FROM ubuntu:22.04

ENV SHELL=/bin/bash
ENV LANG=en_US.UTF-8
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

COPY base_setup.sh /base_setup.sh

RUN chmod +x /base_setup.sh && /base_setup.sh && rm /base_setup.sh

USER 1000

RUN bash