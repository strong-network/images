wget -O /ide.tar.gz https://download-cf.jetbrains.com/go/goland-2021.3.3.tar.gz
/unzip_ide.sh

wget -O golang_sdk-linux-amd64.tar.gz https://golang.org/dl/go1.19.linux-amd64.tar.gz

tar -C /usr/local -xzf golang_sdk-linux-amd64.tar.gz
rm golang_sdk-linux-amd64.tar.gz

# clean apt to reduce image size
sudo rm -rf /var/lib/apt/lists/*
sudo rm -rf /var/cache/apt
# change permissions
chown -R developer:developer /ide/bin