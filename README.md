# dotfiles

[![Build Status](https://travis-ci.org/ephimoff/dotfiles.svg?branch=master)](https://travis-ci.org/ephimoff/dotfiles)

## Introduction

A collection of scripts to bootstrap a clean install of macOS.

## Installation

1. Install xcode from the app store.

1. Open xcode and accept the license agreement.

1. Install xcode command line tools:

    ```sh
    xcode-select --install
    ```

1. Clone this repo by running the following commands:

    ```sh
    mkdir ~/Projects
    git clone https://github.com/ephimoff/dotfiles.git ~/Projects/dotfiles
    ```

1. Install homebrew by running the following command:

    ```sh
    ~/Projects/dotfiles/.brew_install
    ```

1. Run the following command to do everything.  _Note: you will be prompted for your password a number of times during script execution._

    ```sh
    ~/Projects/dotfiles/bootstrap.sh
    ```

    Essentially, `bootstrap.sh` executes the following commands:

    ```sh
    # Create useful directories.
    ~/Projects/dotfiles/.directories

    # Backup existing dotfiles and symlink to the dotfiles in this project.
    ~/Projects/dotfiles/.dotfiles

    # Copy templates to ~. These files don't really belong in version control, hence they are not symlinked.
    ~/Projects/dotfiles/.templates

    # Configure sensible defaults in macOS.
    ~/Projects/dotfiles/.macos

    # Install command line package manager and additional command line tools.
    ~/Projects/dotfiles/.brew

    # Install command line package manager and additional applications.
    ~/Projects/dotfiles/.cask

    # Install MAS using Homebrew and apps from Mac App Store
    ~/Projects/dotfiles/.mas

    # Apply preferences to applications.
    ~/Projects/dotfiles/.preferences

    # Install oh_my_zsh.
    ~/Projects/dotfiles/.oh_my_zsh
    ```

1. Restart your computer.

## Update

Run the following commands to get the latest version of this project:

```sh
cd ~/Projects/dotfiles/
git pull origin master
```

## What's included

### .directories

Creates 3 folders:

1. `~/Downloads/.transmission/incomplete`
1. `~/Projects/eclipse_workspace`
1. `~/tmp`

Create a symlink to the scripts

### .dotfiles

* Backs up the current dotfiles to `~/.dotfiles_backup`
* Sets up aliases, shell variables and paths, creates useful functions
* Sets up GIT config (i.e. GIT message, GIT ignore etc.)
* Adds `.zshrc` configuration

### .templates

* Sets up GIT credentials
* Adds more paths

### .macos

Sets up macOS settings. See the output to find out what are the settings.

### .brew

Updates Homebrew and installs the following packages:

* `ack`
* `ansible`
* `bash-completion`
* `bash`
* `docker-compose-completion`
* `git`
* `heroku`
* `jq`
* `rbenv ruby-build`
* `rbenv`
* `shellcheck`
* `sqlite3`
* `vagrant-completion`
* `vim --with-custom-python`
* `zsh`

### .mas

Install Mac App Store apps:

* The Unarchiver
* 1Password
* OneDrive
* iMovie
* Pages
* iA Writer

### .cask

Install Cask and the following packages apps and fonts:

* `caffeine`
* `cyberduck`
* `dash`
* `docker`
* `dropbox`
* `firefox`
* `flycut`
* `font-fira-code`
* `font-source-code-pro`
* `font-source-code-pro-for-powerline`
* `google-chrome`
* `google-drive`
* `hipchat`
* `iterm2`
* `java`
* `joinme`
* `skype`
* `soapui`
* `sourcetree`
* `spectacle`
* `spotify`
* `transmission`
* `virtualbox`
* `virtualbox-extension-pack`
* `visual-studio-code`
* `vlc`
* `qlstephen`

### .preferences

Updates preferences for the following apps:

* joinMe
* python
* ruby
* Skype
* SourceTree
* ssh
* Vagrant
* vim
* Visual Studio Code

### .oh_my_zsh

Installs [oh_my_zsh](http://ohmyz.sh) shell

## Feedback

Suggestions/improvements [welcome](https://github.com/ephimoff/dotfiles/issues)!

## Acknowedgements

* [Mathias Bynens](https://github.com/mathiasbynens)
* [Craig Hurley](https://github.com/craighurley/dotfiles)
* [atomantic](https://github.com/atomantic/dotfiles)

## Warning / Liability

> Warning: The creator of this repo is not responsible if your machine ends up in a state you are not happy with. If you are concerned, look at the code to review everything this will do to your machine :)
