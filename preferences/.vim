#!/usr/bin/env bash

###############################################################################
# vim
###############################################################################

vim=$(which vim)
echo "VIM: Installing plugins"
# install plugins
mkdir -p ~/.vim/bundle/
if [[ ! -d ~/.vim/bundle/Vundle.vim ]] ; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

$vim -e -c PluginInstall -c quitall 2> /dev/null