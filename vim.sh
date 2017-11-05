#!/bin/bash

echo "compiling vim 8"

# checkout the vim repo
mkdir -p $HOME/sources
git clone https://github.com/vim/vim $HOME/sources/vim

# apply a patch to configure the build
cp vim.patch $HOME/sources/vim/
cd $HOME/sources/vim/
git apply vim.patch

# compile and install
make
sudo make install
