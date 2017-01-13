#!/usr/bin/env bash

# include colorized echo
source ./bin/echos.sh

bot "Hi! I'm going to install tooling and tweak your system settings. Here I go..."

directory=~/Projects/dotfiles

$directory/.directories
$directory/.dotfiles
$directory/.templates
$directory/.macos
$directory/.brew
$directory/.cask
$directory/.mas
$directory/.preferences
$directory/.oh_my_zsh

# Finished
bot "$(basename "$0") complete."
