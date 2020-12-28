# set XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# set zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"   # history filepath
export HISTSIZE=10000                  # Maximum events for internal history
export SAVEHIST=10000                  # Maximum events in history file

# set editor, use vim as default
export EDITOR="nvim"
export VISUAL="nvim"
