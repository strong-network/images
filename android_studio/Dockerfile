FROM sn_base

RUN wget -O ide.tar.gz https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2021.1.1.21/android-studio-2021.1.1.21-linux.tar.gz && \
    /validate_file_hash 3de3092082df6ae9d3969478115efaa909539590dc5a829eb3ad6a7bd5bda2a4  ide.tar.gz && \
    /unzip_ide.sh && \
    chown -R developer:developer /ide/bin && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt

USER developer

WORKDIR /home/developer