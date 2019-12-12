#!/usr/bin/env bash

# Start
echo "Starting $(basename "$0")"

dotfiles_repo="git@github.com:ephimoff/dotfiles.git"
dotfiles_repo_dest="${HOME}/Projects/dotfiles"

echo "Clonning a dotfiles repository: $dotfiles_repo"
git clone "$dotfiles_repo" "$dotfiles_repo_dest"

# Finished
echo "$(basename "$0") complete."
