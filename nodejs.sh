#!/bin/bash

## nodejs
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get --yes install nodejs

## yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update && sudo apt-get install yarn
