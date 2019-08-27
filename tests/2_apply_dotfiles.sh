#!/usr/bin/env bash

set -e
set -o pipefail
IFS=$'\n'

# run dotfiles

"./directories.sh"
"./templates.sh"
"./macos.sh"
"./brew.sh"
"./oh_my_zsh.sh"
"./dotfiles.sh"
"./preferences.sh"
