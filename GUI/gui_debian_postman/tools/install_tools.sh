#!/bin/sh
set -e

apt-get update 
wget "https://dl.pstmn.io/download/latest/linux_64" -O /tmp/postman.tar.gz 
tar xvf /tmp/postman.tar.gz -C /opt/ 
rm /tmp/postman.tar.gz

# Create desktop entry
mkdir -p /usr/share/applications 
echo "[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=/opt/Postman/app/Postman %U
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;" > /usr/share/applications/Postman.desktop

apt-get install -y chromium 
ln -sfn /usr/bin/chromium /usr/bin/chromium-browser 
echo "[Desktop Entry]
Name=Chromium
Comment=Web Browser
Exec=/usr/bin/chromium %U
Terminal=false
Type=Application
Icon=chromium
Categories=Network;WebBrowser;" > /usr/share/applications/chromium.desktop

# Add apps to desktop
mkdir -p /home/developer/Desktop
cp /usr/share/applications/Postman.desktop /home/developer/Desktop
sudo chmod +x /home/developer/Desktop/Postman.desktop

# Clean up
apt-get clean
rm -rf /var/lib/apt/lists/*