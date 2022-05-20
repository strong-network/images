#!/usr/bin/env sh

apt-get update 
DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get install unzip openjdk-11-jdk -y
DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get install procps -y
DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get install libxext6 libxrender1 libxtst6 libxi6 libfreetype6 maven -y