#!/usr/bin/env bash

set -e
set -o pipefail
IFS=$'\n'

# run dotfiles
"$(dirname "$(pwd)")"/bootstrap.sh
