#!/bin/bash

# Setup the home directory with a python in bin/
(
rm -rf $HOME/bin/py;
mkdir -p $HOME/bin/py;
cd $HOME/bin/py;
virtualenv --system-site-packages .;

)

# add the bin/py to path in case it's not there by sourcing .profile again.
source $HOME/.profile;

pip install -U pip

# install latest setuptools
# https://pypi.python.org/pypi/setuptools
curl https://bootstrap.pypa.io/ez_setup.py -o - | python
rm -f setuptools-*.zip

# Setup for packaging
pip install wheel;
pip install twine;
