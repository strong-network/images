FROM sn_generic

USER 1000

RUN wget -O jfrog.vsix https://open-vsx.org/api/JFrog/jfrog-vscode-extension/2.14.5/file/JFrog.jfrog-vscode-extension-2.14.6.vsix && \
    /validate_file_hash 27d648d87c1d89867fe52b0e9707feab6df6fb1559b9879a183f30ff39bcb71f  jfrog.vsix && \
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