FROM sn_generic

RUN wget -O jfrog.vsix https://open-vsx.org/api/JFrog/jfrog-vscode-extension/2.8.1/file/JFrog.jfrog-vscode-extension-2.8.1.vsix && \
    /validate_file_hash 8e7dbfc2c63c4405ee89ef5578ad4db1a119200664f717fba2f736439f5ff03b  jfrog.vsix && \
    mv jfrog.vsix /usr/bin/strong_network_startup/vscode_extensions


WORKDIR /

USER 0

RUN wget -qO jfrog_public_gpg.key https://releases.jfrog.io/artifactory/jfrog-gpg-public/jfrog_public_gpg.key && \
    /validate_file_hash e4faf9f9ecdc803b3a1803df0474651607779336eda04bb1dbcc9fdab0e474cf  jfrog_public_gpg.key && \
    cat jfrog_public_gpg.key | apt-key add - && rm jfrog_public_gpg.key && \
    echo "deb https://releases.jfrog.io/artifactory/jfrog-debs xenial contrib" | tee -a /etc/apt/sources.list && apt update && \
    apt install -y jfrog-cli-v2-jf

WORKDIR /home/developer

USER 1000