wget -O anaconda.sh https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh
update-alternatives --install /usr/bin/python python /usr/bin/python3 10
update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10
mv install_python_anaconda.sh /usr/bin/strong_network_startup/install_python_anaconda.sh
chmod 4755 /usr/bin/strong_network_startup/install_python_anaconda.sh
pip install --upgrade pip setuptools
pip install pylint autopep8 python-language-server scikit-image scikit-learn tensorflow keras notebook jupyterlab voila jupyter pandas seaborn graphviz
mkdir anaconda_installer
mv anaconda.sh /anaconda_installer/anaconda.sh