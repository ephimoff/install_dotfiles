#!/usr/bin/env bash

echo "During the installation you might need to type the system password several times."
echo "Note that some of these changes require a logout/restart to take effect."

directory="${HOME}/Projects/install_dotfiles"

"$directory/clone_dotfiles.sh"
"$directory/directories.sh"
"$directory/templates.sh"
"$directory/macos.sh"
"$directory/brew.sh"
"$directory/oh_my_zsh.sh"
"$directory/dotfiles.sh"
"$directory/preferences.sh"

# Finished
echo "$(basename "$0") complete."
