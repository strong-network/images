FROM strong_network_base

ENV ANDROID_HOME /home/developer/androidsdk
ENV QTWEBENGINE_DISABLE_SANDBOX 1
ENV WINDOW_MANAGER openbox
ENV PATH /home/developer/flutter/bin:/home/developer/androidsdk/emulator:/home/developer/androidsdk/tools:/home/developer/androidsdk/cmdline-tools/bin:/home/developer/androidsdk/platform-tools:${PATH}

COPY --chown=developer:developer setup.sh /setup.sh
COPY --chown=developer:developer  novnc-index.html /novnc-index.html
COPY start-vnc-session.sh /start-vnc-session.sh
COPY install_flutter.sh /install_flutter.sh

RUN chmod +x setup.sh && /setup.sh && rm /setup.sh

USER 1000

WORKDIR /home/developer