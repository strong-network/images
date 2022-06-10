FROM sn_base

COPY setup.sh /setup.sh

COPY unzip_ide.sh /unzip_ide.sh

RUN chmod +x /unzip_ide.sh && chmod +x /setup.sh && /setup.sh && rm /setup.sh 