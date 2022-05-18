update-alternatives --install /usr/bin/python python /usr/bin/python3 10
update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10
mv install_python_spark.sh /usr/bin/strong_network_startup/install_python_spark.sh
mv kernel.json /usr/bin/strong_network_startup/kernel.json
chmod 666 /usr/bin/strong_network_startup/kernel.json
chmod 4755 /usr/bin/strong_network_startup/install_python_spark.sh
pip install --upgrade pip setuptools
pip install pylint autopep8 python-language-server scikit-image scikit-learn tensorflow keras notebook jupyterlab voila jupyter pandas seaborn graphviz