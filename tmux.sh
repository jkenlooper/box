#!/bin/bash

curl https://github.com/tmux/tmux/releases/download/2.3/tmux-2.3.tar.gz -O -L
tar -xf tmux-2.3.tar.gz
rm tmux-2.3.tar.gz
cd tmux-2.3

./configure && make

# Install as root
make install

# Cleanup
cd ../
rm -rf tmux-2.3
