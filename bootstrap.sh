#!/usr/bin/env bash

directory=~/Projects/dotfiles

# $directory/.directories
$directory/.dotfiles
$directory/.templates
$directory/.macos
$directory/.brew
$directory/.cask
$directory/.mas
$directory/.preferences
$directory/.oh_my_zsh

# Finished
echo "$(basename "$0") complete."
