#!/bin/sh

ROOT_PATH=`pwd -P`

mkdir -p $HOME/.config/nvim/bundle/vundle
git clone git://github.com/gmarik/vundle.git $HOME/.config/nvim/bundle/vundle
ln -nfs $ROOT_PATH/init.vim $HOME/.config/nvim/init.vim
nvim +BundleInstall +qall

