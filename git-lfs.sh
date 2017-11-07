#!/bin/bash

# https://packagecloud.io/github/git-lfs/install#manual-deb

curl -L https://packagecloud.io/github/git-lfs/gpgkey | sudo apt-key add -

sudo apt-get update

sudo apt-get install --yes apt-transport-https

sudo cp github_git-lfs.list /etc/apt/sources.list.d/

sudo apt-get update

sudo apt-get install git-lfs

echo "Installed git-lfs; initialize via 'git lfs install' command"
