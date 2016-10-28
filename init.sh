#!/bin/bash

apt-get --yes update
apt-get --yes upgrade

apt-get --yes install git curl
# Use latest patched tmux with true color support
apt-get --yes install tmux

apt-get --yes install python-virtualenv
apt-get --yes install python-dev python-pip python3-dev python3-pip

# To be able to use add-apt-repository you may need to install software-properties-common:
apt-get install software-properties-common

# Install support for compiling
apt-get --yes install build-essential cmake;
apt-get --yes install libevent-dev libncurses-dev

# install support for Pillow
apt-get --yes install libtiff4-dev libjpeg8-dev zlib1g-dev \
      libfreetype6-dev liblcms2-dev libwebp-dev tcl8.5-dev tk8.5-dev python-tk


# Install more stuff for web development
apt-get --yes install sqlite3 python-sqlite
apt-get --yes install optipng
