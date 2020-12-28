# use neovim
alias vim='nvim'

# Edit command line in vim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Completion system
autoload -Uz compinit; compinit
fpath=(/usr/share/zsh/site-functions/ $fpath)

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
