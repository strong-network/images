FROM sn_gui_ubuntu
ARG user=developer

USER root
WORKDIR /


#### #### Eclipse #### ####
ARG eclipseVersion=2025-03/M1/eclipse-committers-2025-03-M1-linux-gtk-x86_64.tar.gz
RUN wget -O eclipse.tar.gz http://www.mirrorservice.org/sites/download.eclipse.org/eclipseMirror/technology/epp/downloads/release/${eclipseVersion}
RUN tar -xvzf eclipse.tar.gz --directory /opt && rm eclipse.tar.gz
COPY tools/eclipse.desktop /opt/eclipse.desktop
RUN desktop-file-install /opt/eclipse.desktop
#### #### Eclipse #### ####

#### #### VSCode #### ####
# add microsoft's gpg key and the vscode repository
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    sh -c 'echo "deb [arch=amd64,arm64,armhf] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' && \
    rm microsoft.gpg
# install vsCode
RUN apt-get update && \
    apt-get install -y code
#### #### VSCode #### ###

#### #### Python3 #### ###
RUN apt-get install -y python3-dev python3-pip
RUN python3 -m pip install --upgrade pip
#### ####  Python3 #### ###

#### ####  Chrome #### ###
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    sudo apt install -y ./google-chrome-stable_current_amd64.deb && \
    rm google-chrome-stable_current_amd64.deb
#### ####  Chrome #### ###

#### ####  SVN #### ###
RUN apt-get install -y subversion
#### ####  SVN #### ###

USER ${user}
WORKDIR /home/developer