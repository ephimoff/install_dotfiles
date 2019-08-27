#!/usr/bin/env bash

# Start
echo "Starting $(basename "$0")"

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor

# Finished
echo "$(basename "$0") complete."
