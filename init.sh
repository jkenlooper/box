#!/bin/bash

echo "Create a user login for the box"
read -p "adduser [] " INIT_USER
adduser $INIT_USER
echo "Setting $INIT_USER to sudo group"
usermod -aG sudo $INIT_USER

read -n 1 -p "Copy the id_rsa.pub key for the remote ... press any key to continue";

mkdir -p /home/$INIT_USER/.ssh
chown jake:jake /home/$INIT_USER/.ssh
chmod 700 /home/$INIT_USER/.ssh
read -p "paste in the key to append to .ssh/authorized_keys: " PUB_KEY
echo "$PUB_KEY" >> /home/$INIT_USER/.ssh/authorized_keys
chown jake:jake /home/$INIT_USER/.ssh/authorized_keys
chmod 600 /home/$INIT_USER/.ssh/authorized_keys

echo "Enable firewall"
ufw allow OpenSSH
ufw allow 80/tcp
#ufw allow 443/tcp
ufw show added
ufw enable

