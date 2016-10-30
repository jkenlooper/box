#!/bin/bash

# clone dot-files repo and run install for that

if test ! -d dotfiles; then
    git clone https://github.com/jkenlooper/dotfiles.git
fi
cd dotfiles;
git pull;
make;
