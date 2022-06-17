# Set the ide.tar.gz file
wget -O /ide.tar.gz https://download.jetbrains.com/idea/ideaIU-2022.1.1.tar.gz
/unzip_ide.sh

DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get install php libapache2-mod-php -y

sudo rm -rf /var/lib/apt/lists/*
sudo rm -rf /var/cache/apt

chown -R developer:developer /ide/bin