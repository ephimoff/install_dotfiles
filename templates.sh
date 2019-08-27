#!/usr/bin/env bash
# Start
echo "Starting $(basename "$0")"

directory=~/Projects/dotfiles/templates
files=$(find $directory -iname ".*" -maxdepth 1 -type f)

# shellcheck disable=SC2068
for file in ${files[@]} ; do
  [[ ! -f "$HOME/$(basename "$file")" ]] && cp "$file" ~/
done

# Finished
echo "$(basename "$0") complete."