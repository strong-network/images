#!/bin/bash

set -e

SSH_KEY_DIRECTORY="/opt/keys"
PY_SPARK_PASS=$(cat $SSH_KEY_DIRECTORY/proxy_pass)

# config.json for spark connection
CONFIGJSON=$(cat <<EOF
{
  "kernel_python_credentials" : {
    "username": "${HOSTNAME}",
    "base64_password": "${PY_SPARK_PASS}",
    "url": "http://${SSHPROXY_URL}:8080/pysparkproxy"
  },

  "kernel_scala_credentials" : {
    "username": "${HOSTNAME}",
    "base64_password": "${PY_SPARK_PASS}",
    "url": "http://${SSHPROXY_URL}:8080/pysparkproxy"
  },
  "custom_headers" : {
    "X-Requested-By": "livy"
  },
  "heartbeat_refresh_seconds": 5,
  "livy_server_heartbeat_timeout_seconds": 120,
  "heartbeat_retry_seconds": 1
}
EOF
)

# install python extension
/strong/strong-ide/bin/strong-ide --extensions-dir /home/developer/.local/share/strong-ide/extensions --install-extension ms-python.python # Disable version TODO:oz @2020.10.332292344
python3 -m venv .sparkenv
source .sparkenv/bin/activate
pip install wheel
pip install sparkmagic==0.13.1
jupyter nbextension enable --py --sys-prefix widgetsnbextension 
cd /home/developer/.sparkenv/lib/python3.8/site-packages
sudo jupyter-kernelspec install sparkmagic/kernels/pysparkkernel
sudo mv /usr/local/share/jupyter/kernels/pysparkkernel /home/developer/.sparkenv/share/jupyter/kernels/
jupyter serverextension enable --py sparkmagic
sudo mkdir /home/developer/.sparkmagic/
sudo rm /home/developer/.sparkenv/share/jupyter/kernels/pysparkkernel/kernel.json
sudo cp /usr/bin/strong_network_startup/kernel.json /home/developer/.sparkenv/share/jupyter/kernels/pysparkkernel/kernel.json
sudo chmod -R 777 /home/developer/.sparkmagic/
sudo chmod -R 777 /home/developer/.sparkenv/share/jupyter/kernels/
echo -e "$CONFIGJSON" > /home/developer/.sparkmagic/config.json