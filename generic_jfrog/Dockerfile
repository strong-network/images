FROM sn_generic

USER 1000

RUN wget -O jfrog.vsix https://open-vsx.org/api/JFrog/jfrog-vscode-extension/2.10.1/file/JFrog.jfrog-vscode-extension-2.10.1.vsix && \
    /validate_file_hash 8b0dc85a4e1f8c19f0bf44dc8cc3d809e6ede854b2f3d7d1562c3cfee9d3ec44  jfrog.vsix && \
    mv jfrog.vsix /usr/bin/strong_network_startup/vscode_extensions

WORKDIR /

USER 0

RUN mkdir -p /etc/apt/keyrings && \
    wget -qO - https://releases.jfrog.io/artifactory/api/gpg/key/public | gpg --batch --yes --dearmor -o /etc/apt/keyrings/jfrog.gpg && \
    wget -qO - https://releases.jfrog.io/artifactory/api/security/keypair/public/repositories/jfrog-debs | gpg --batch --yes --dearmor -o /etc/apt/keyrings/jfrog-archive.gpg && \
    chmod a+r /etc/apt/keyrings/jfrog.gpg /etc/apt/keyrings/jfrog-archive.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/jfrog.gpg,/etc/apt/keyrings/jfrog-archive.gpg] https://releases.jfrog.io/artifactory/jfrog-debs xenial contrib" | tee /etc/apt/sources.list.d/jfrog.list && \
    apt update && \
    apt install -y jfrog-cli-v2-jf

WORKDIR /home/developer

USER 1000