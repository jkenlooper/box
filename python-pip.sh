#!/bin/bash

pip install -U pip

# install latest setuptools
# https://pypi.python.org/pypi/setuptools
curl https://bootstrap.pypa.io/ez_setup.py -o - | python
rm -f setuptools-*.zip

# Setup for packaging
pip install wheel;
pip install twine;
