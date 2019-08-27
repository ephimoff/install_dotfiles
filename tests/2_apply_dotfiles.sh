#!/usr/bin/env bash

set -e
set -o pipefail
IFS=$'\n'

# run dotfiles
echo "Current dir is $(pwd)"
# echo "The content of this dir is:"
# ls -la
"./bootstrap.sh"
# "$(dirname "$(pwd)")/bootstrap.sh"
