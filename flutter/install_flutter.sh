#!/usr/bin/env bash

export FLUTTER_VERSION=2.5.3-stable

cd /home/developer
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}.tar.xz
tar -xvf flutter*.tar.xz
rm -f flutter*.tar.xz

flutter/bin/flutter precache

wget https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip
mkdir -p $ANDROID_HOME/cmdline-tools/latest
unzip commandlinetools-linux-*.zip -d $ANDROID_HOME
rm -f commandlinetools-linux-*.zip
mv $ANDROID_HOME/cmdline-tools/bin $ANDROID_HOME/cmdline-tools/latest 
mv $ANDROID_HOME/cmdline-tools/lib $ANDROID_HOME/cmdline-tools/latest

yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "platform-tools" "platforms;android-30" "emulator" "build-tools;30.0.3"
yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "system-images;android-30;google_apis;x86_64"
# $ANDROID_HOME/cmdline-tools/latest/bin/avdmanager create avd -n avd28 -k "system-images;android-30;google_apis;x86_64"