#!/usr/bin/env bash

echo "During the installation you might need to type the system password several times."
echo "Note that some of these changes require a logout/restart to take effect."

directory="${HOME}/Projects/install_dotfiles"

dotfiles_repo="https://github.com/ephimoff/dotfiles.git"
dotfiles_repo_dest="${HOME}/Projects/dotfiles"

echo "Clonning a dotfiles repository: $dotfiles_repo"
git clone "$dotfiles_repo" "$dotfiles_repo_dest"

echo "current dir is ______$(pwd)"
echo "... compare it to ___$directory"
echo " content of the current directory is: "
ls -la
echo "-----------"


"$directory/directories.sh"
"$directory/templates.sh"
"$directory/macos.sh"
"$directory/brew.sh"
# "$directory/cask.sh"
"$directory/oh_my_zsh.sh"
"$directory/dotfiles.sh"
"$directory/preferences.sh"

# Finished
echo "$(basename "$0") complete."
