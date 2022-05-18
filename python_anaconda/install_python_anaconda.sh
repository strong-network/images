#!/bin/bash

set -e

# install python extension
/strong/strong-ide/bin/strong-ide --extensions-dir /home/developer/.local/share/strong-ide/extensions --install-extension ms-python.python #Disable version for now TODO:oz  @2020.10.332292344

bash /anaconda_installer/anaconda.sh  -b -p /home/developer/anaconda3

eval "$( /home/developer/anaconda3/bin/conda shell.bash hook)"
conda init