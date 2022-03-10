# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# set common aliases
# use neovim
alias vim='nvim'
# show color in ls
alias ls='ls --color=auto'

# Use emacs keybinding in Terminal
bindkey -e

# Enable command line editing in vim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# Zsh plugins
# -----------
# Theme
source $HOME/.local/share/zsh/plugins/zsh-theme-powerlevel10k/config/p10k-rainbow.zsh
source $HOME/.local/share/zsh/plugins/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Auto suggestions
source $HOME/.local/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# ---------------------------------------------

# Syntax highlighting
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Completion system
autoload -Uz compinit; compinit
fpath=(/usr/share/zsh/site-functions/ $fpath)

# run keychain
eval $(keychain --eval --quiet id_rsa)

# add .local/bin and .emacs.d/bin to PATH
export PATH="$PATH:/home/yueting/.local/bin:/home/yueting/.emacs.d/bin"

# To customize prompt, run `p10k configure` or edit ~/dotfiles/.config/zsh/.p10k.zsh.
[[ ! -f ~/dotfiles/.config/zsh/.p10k.zsh ]] || source ~/dotfiles/.config/zsh/.p10k.zsh
