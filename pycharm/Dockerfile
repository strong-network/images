FROM sn_base

RUN wget -O /ide.tar.gz https://download-cf.jetbrains.com/python/pycharm-community-2021.3.2.tar.gz && \
    /validate_file_hash f1ae01f471d01c6f09aab0a761c6dea9834ef584f2aaf6d6ebecdce6b55a66e8  ide.tar.gz && \
    /unzip_ide.sh && \
    chown -R developer:developer /ide/bin

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10 && \
    update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10 && \
    pip install pylint autopep8 python-language-server && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt

USER developer

WORKDIR /home/developer