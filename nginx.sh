#!/bin/bash

sudo apt-get --yes install nginx

# for getting the htpasswd util
sudo apt-get --yes install apache2-utils

echo "Create the .htpasswd file"
htpasswd -c $HOME/.htpasswd jake

echo "Creating error pages in $HOME/public/"
mkdir -p $HOME/public
cp nginx/*.html $HOME/public/

read -p "Update ip in nginx/local.conf"
sudo cp nginx/local.conf /etc/nginx/sites-available/local.conf
sudo ln -fs /etc/nginx/sites-available/local.conf /etc/nginx/sites-enabled/local.conf
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t && sudo nginx -s reload
