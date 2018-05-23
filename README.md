# dotfiles

![Logo of the project](./images/logo.png)

[![Build Status](https://travis-ci.org/ephimoff/dotfiles.svg?branch=master)](https://travis-ci.org/ephimoff/dotfiles)

A collection of scripts to bootstrap a clean install of macOS.

<!-- TOC -->

- [Installation](#installation)
- [Update](#update)
- [What's included](#whats-included)
    - [`.directories`](#directories)
    - [`.dotfiles`](#dotfiles)
    - [`.macos`](#macos)
    - [`.brew`](#brew)
    - [`.cask`](#cask)
    - [`.additional_apps`](#additional_apps)
    - [`.mas`](#mas)
    - [`.preferences`](#preferences)
    - [`.oh_my_zsh`](#oh_my_zsh)
- [Feedback](#feedback)
- [Acknowedgements](#acknowedgements)
- [Warning / Liability](#warning--liability)

<!-- /TOC -->

## Installation

1. [UPDATE: Hombrew now installs the XCode Command line tools for you] ~~Install xcode from the app store.~~
1. ~~Open xcode and accept the license agreement.~~
1. ~~Install xcode command line tools:~~
1. Clone this repository by running the following commands:

    ```
    mkdir ~/Projects
    git clone https://github.com/ephimoff/dotfiles.git ~/Projects/dotfiles
    ```

1. Install homebrew by running the following command:

    ```
    ~/Projects/dotfiles/.brew_install
    ```

1. Run the following command to do everything.  _Note: you will be prompted for your password a number of times during script execution._

    ```
    ~/Projects/dotfiles/bootstrap.sh
    ```

    Essentially, `bootstrap.sh` executes the following commands:

    ```
    # Create useful directories.
    ~/Projects/dotfiles/.directories

    # Backup existing dotfiles and symlink to the dotfiles in this project.
    ~/Projects/dotfiles/.dotfiles

    # Configure sensible defaults in macOS.
    ~/Projects/dotfiles/.macos

    # Install command line package manager and additional command line tools.
    ~/Projects/dotfiles/.brew

    # Install command line package manager and additional applications.
    ~/Projects/dotfiles/.cask

    # Apply preferences to applications.
    ~/Projects/dotfiles/.preferences

    # Install oh_my_zsh.
    ~/Projects/dotfiles/.oh_my_zsh
    ```

1. Install additional applications if you want:

    ```
    ~/Projects/dotfiles/.additional_apps
    ```

1. Install MAS apps by running the following command. Note: You have to sign in to Apple Mac App Store first.

    ```
    ~/Projects/dotfiles/.mas
    ```

1. Restart your computer.

## Update

Run the following commands to get the latest version of this project:

```
cd ~/Projects/dotfiles/
git pull origin master
```

## What's included

### `.directories`

Creates 3 folders:

1. `~/Downloads/.transmission/incomplete`
1. `~/Projects/eclipse_workspace`
1. `~/tmp`

Create a symlink to the scripts

### `.dotfiles`

- Backs up the current dotfiles to `~/.dotfiles_backup`
- Sets up aliases, shell variables and paths, creates useful functions
- Sets up GIT config (i.e. GIT message, GIT ignore etc.)
- Adds `.zshrc` configuration

### `.macos`

Sets up macOS settings. See the output to find out what are the settings.

### `.brew`

Updates Homebrew and installs some packages

### `.cask`

Installs casks

### `.additional_apps`

This is completely optional. Comment it out if you don't want it. Just a list of apps that I usually install

### `.mas`

Installs Mac App Store apps. Note: You have to sign in to Apple Mac App Store first.

### `.preferences`

Updates apps preferences

### `.oh_my_zsh`

Installs [oh_my_zsh](http://ohmyz.sh) shell

## Feedback

Suggestions/improvements [welcome](https://github.com/ephimoff/dotfiles/issues)!

## Acknowedgements

- [Mathias Bynens](https://github.com/mathiasbynens)
- [Craig Hurley](https://github.com/craighurley/dotfiles)
- [atomantic](https://github.com/atomantic/dotfiles)

## Warning / Liability

> Warning: The creator of this repository is not responsible if your machine ends up in a state you are not happy with. If you are concerned, look at the code to review everything this will do to your machine :)
