# Installing dotfiles

[![Build Status](https://travis-ci.org/ephimoff/install_dotfiles.svg?branch=master)](https://travis-ci.org/ephimoff/install_dotfiles)

A collection of scripts that installs dotfiles from [this repo](https://github.com/ephimoff/dotfiles)

## Installation

1. Make sure you have GIT installed. Hint: it comes with the xcode command line tools.
1. Clone this repository by echo the following commands:

    ```
    mkdir ~/Projects
    git clone https://github.com/ephimoff/install_dotfiles.git ~/Projects/install_dotfiles
    ```

1. Install homebrew by running the following command:

    ```
    ~/Projects/install_dotfiles/.brew_install
    ```

1. Run the following command to do everything.  _Note: you will be prompted for your password a number of times during script execution._

    ```
    ~/Projects/install_dotfiles/bootstrap.sh
    ```

1. Restart your computer.

## Update

Run the following commands to get the latest version of this project:

```
cd ~/Projects/install_dotfiles/
git pull origin master
```

## Feedback

Suggestions/improvements [welcome](https://github.com/ephimoff/install_dotfiles/issues)!

## Acknowedgements

- [Mathias Bynens](https://github.com/mathiasbynens)
- [Craig Hurley](https://github.com/craighurley/dotfiles)

## Warning / Liability

> Warning: The creator of this repository is not responsible if your machine ends up in a state you are not happy with. If you are concerned, look at the code to review everything this will do to your machine :)
