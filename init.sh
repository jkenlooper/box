#!/bin/bash

apt-get --yes update
apt-get --yes upgrade

apt-get --yes install git curl
apt-get --yes install tmux

apt-get --yes install python-virtualenv
apt-get --yes install python-dev python-pip python3-dev python3-pip

# To be able to use add-apt-repository you may need to install software-properties-common:
apt-get install software-properties-common

# Install support for compiling
apt-get --yes install build-essential cmake;
