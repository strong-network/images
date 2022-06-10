#!/usr/bin/env sh

wget -O /ide.tar.gz https://download-cf.jetbrains.com/python/pycharm-community-2021.3.2.tar.gz
/unzip_ide.sh

update-alternatives --install /usr/bin/python python /usr/bin/python3 10
update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10
pip install pylint autopep8 python-language-server

clean apt to reduce image size
sudo rm -rf /var/lib/apt/lists/*
sudo rm -rf /var/cache/apt

# change permissions
chown -R developer:developer /ide/bin