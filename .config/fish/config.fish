if status --is-interactive
    # Commands to run in interactive sessions can go here
    set SHELL /usr/bin/fish
    eval (keychain --eval --quiet -Q id_rsa --nogui)
end
# add pyenv
if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end

# add aliases here, this does not take advantage of lazy loading, but simpler
alias ssh "kitty +kitten ssh"    # for kitty to use ssh properly (kitty's term sheet needs to be sent to remote)
# alias vim nvim     usr symlink within neovim deployment

# use fisher to manage plugins
# install tide and theme it like powerlevel10k in zsh

# Created by `pipx` on 2023-06-19 13:03:05
set PATH $PATH /home/yueting/.local/bin

# Add doom emacs to PATH
set PATH $PATH /home/yueting/.config/emacs/bin/
