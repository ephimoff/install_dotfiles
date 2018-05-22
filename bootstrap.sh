#!/usr/bin/env bash

# include colorized echo
# shellcheck disable=SC1090
source "${HOME}/Projects/dotfiles/bin/echos.sh"

bot "Hi! I'm going to install tooling and tweak your system settings."
bot "During the installation you might need to type the system password several times."
bot "Note that some of these changes require a logout/restart to take effect."
bot "Some of the apps require the manual enabling of the accessability settings."
bot "Here I go..."

directory=~/Projects/dotfiles

$directory/.directories
# $directory/.templates
$directory/.macos
$directory/.brew
$directory/.cask
$directory/.additional_apps
$directory/.oh_my_zsh
$directory/.dotfiles
$directory/.preferences

# Finished
bot "$(basename "$0") complete."
