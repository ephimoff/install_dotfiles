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

# for Sierra remember ssh keys
# Add all known keys to the SSH agent
ssh-add -A 2>/dev/null;

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias ll='ls -alF'
alias v="vim"
alias vi="vim"
alias o="open"
alias oo="open ."
alias x+="chmod +x"
alias -- +x="chmod +x"

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

# Remove duplicates in the 'Open With' menu
alias clearOpen="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv $HOME/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Download file and save it with filename of remote file
alias get="curl -O -L"

# Directories
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias pro="cd ~/Projects"

#orion
alias rdep="rgrav deploy -R unison_frontend:0 -R unison_backend:0 -R unison_haproxy:0 -R connect:0 -p ec2"
alias rinv="rgrav invoke -p ec2"

#git
alias gst="git s"

#vagrant
alias va="vagrant"