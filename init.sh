#!/bin/bash

echo "Create a user login for the box"
read -p "adduser [] " INIT_USER
adduser $INIT_USER
echo "Setting $INIT_USER to sudo group"
usermod -aG sudo $INIT_USER

read -n 1 -p "Copy the id_rsa.pub key for the remote ... press any key to continue";

mkdir -p /home/$INIT_USER/.ssh
chmod 700 /home/$INIT_USER/.ssh
read -p "paste in the key to append to .ssh/authorized_keys: " PUB_KEY
echo $PUB_KEY >> /home/$INIT_USER/.ssh/authorized_keys
chmod 600 /home/$INIT_USER/.ssh/authorized_keys

echo "Enable firewall"
ufw allow OpenSSH
ufw allow 80/tcp
#ufw allow 443/tcp
ufw show added
ufw enable

echo "install and upgrade the things"
apt-get --yes update
apt-get --yes upgrade

apt-get --yes install ntpdate
ntpdate ntp.ubuntu.com

apt-get --yes install git curl
# Use latest patched tmux with true color support
apt-get --yes install tmux

# Install python2 and python3 with pip
apt-get --yes install python
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
