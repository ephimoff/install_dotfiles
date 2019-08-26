#!/usr/bin/env bash

echo "Hi! I'm going to install tooling and tweak your system settings."
echo "During the installation you might need to type the system password several times."
echo "Note that some of these changes require a logout/restart to take effect."
echo "Some of the apps require the manual enabling of the accessability settings."
echo "Here I go..."

directory=~/Projects/dotfiles

$directory/.directories
$directory/.templates
$directory/.macos
$directory/.brew
$directory/.cask
$directory/.oh_my_zsh
$directory/.dotfiles
$directory/.preferences

# Finished
echo "$(basename "$0") complete."
