#!/bin/bash

## neovim
add-apt-repository ppa:neovim-ppa/unstable
apt-get update
apt-get install neovim

# enable Python3 interface with pip:
pip3 install neovim

# deoplete needs neovim-python ver.0.1.8+.
# update neovim-python module.
pip3 install --upgrade neovim

#If you want to use Neovim for some (or all) of the editor alternatives, use the following commands:
update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
update-alternatives --config vi
update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
update-alternatives --config vim
update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
update-alternatives --config editor


# Install vim-plug
mkdir -p .config/nvim/autoload
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
