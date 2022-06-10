#!/usr/bin/env sh

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install gnupg2 -y
curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
curl -fsSL https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list
curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
echo 'deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google-chrome.list
# Install packages
apt-get update
DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get install openjdk-8-jdk build-essential dart apt-transport-https libkrb5-dev gcc make gradle android-tools-adb android-tools-fastboot google-chrome-stable libasound2-dev libnss3-dev fonts-noto libgtk-3-dev xvfb x11vnc xterm openjfx libopenjfx-java openbox emacs-gtk fonts-noto-cjk -y
update-java-alternatives --set java-1.8.0-openjdk-amd64
git clone --depth 1 https://github.com/novnc/noVNC.git /opt/novnc
git clone --depth 1 https://github.com/novnc/websockify /opt/novnc/utils/websockify
mv novnc-index.html /opt/novnc/index.html
mv start-vnc-session.sh /usr/bin/
chmod +x /usr/bin/start-vnc-session.sh
mv install_flutter.sh /usr/bin/strong_network_startup/install_flutter.sh
chmod 4755 /usr/bin/strong_network_startup/install_flutter.sh
apt-get clean -y
rm -rf /var/cache/debconf/* /var/lib/apt/lists/* /tmp/* /var/tmp/*