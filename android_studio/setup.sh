wget -O ide.tar.gz https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2021.1.1.21/android-studio-2021.1.1.21-linux.tar.gz
/unzip_ide.sh

sudo rm -rf /var/lib/apt/lists/*
sudo rm -rf /var/cache/apt

# change permissions
chown -R developer:developer /ide/bin