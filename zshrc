# use neovim
alias vim='nvim'

# Edit command line in vim
# autoload -Uz edit-command-line
# zle -N edit-command-line
# bindkey -M vicmd v edit-command-line

# Use emacs keybinding in Terminal
bindkey -e

# Completion system
autoload -Uz compinit; compinit
fpath=(/usr/share/zsh/site-functions/ $fpath)

# Theme
#source /usr/share/powerline/bindings/zsh/powerline.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Auto suggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
