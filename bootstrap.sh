#!/usr/bin/env bash

echo "During the installation you might need to type the system password several times."
echo "Note that some of these changes require a logout/restart to take effect."

directory=~/Projects/install_dotfiles

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
