#!/usr/bin/env bash

###############################################################################
# vim
###############################################################################
# shellcheck disable=SC1090
source "${HOME}/Projects/dotfiles/bin/echos.sh"

vim=$(which vim)
running "VIM: Installing plugins"
# install plugins
mkdir -p ~/.vim/bundle/
if [[ ! -d ~/.vim/bundle/Vundle.vim ]] ; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

$vim -e -c PluginInstall -c quitall 2> /dev/null
ok