# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=/Users/antone/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="agnoster"
ZSH_THEME="powerlevel9k/powerlevel9k"

# powerlevel9k customisation
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)
POWERLEVEL9K_TIME_BACKGROUND='black'
POWERLEVEL9K_TIME_FOREGROUND='grey'
# Enable command auto-correction.
#ENABLE_CORRECTION="true"

# plugins to load (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git copydir z osx brew)

source $ZSH/oh-my-zsh.sh

# User configuration
# rbenv
eval "$(rbenv init - zsh)"

# export MANPATH="/usr/local/man:$MANPATH"
export PATH="$HOME/Projects/rgrav:$PATH"

# orion: graviton
export PATH="$HOME/.usr/graviton-cli/bin:$PATH"

# orion: graviton
export PATH="$HOME/Projects/scripts:$PATH"

# ssh
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"

# go
export PATH="$PATH:/usr/local/opt/go/libexec/bin"

# packer
export PATH="$PATH:/usr/local/packer"

# for Sierra remember ssh keys
# Add all known keys to the SSH agent
ssh-add -A 2>/dev/null;

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
source "$ZSH_CUSTOM/.aliases"