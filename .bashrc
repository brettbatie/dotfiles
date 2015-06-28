# Add dotfile binaries to path
export PATH=$HOME/dotfiles/bin:$HOME/dotfiles-private/bin:$PATH


# source all files in dotfiles or only the given file
function src() {
  local file
  if [[ "$1" ]]; then
    source "$HOME/dotfiles/source/$1.sh"
  else
    for file in ~/dotfiles*/source/*; do
      source "$file"
    done
  fi
}

src

# add this configuration to ~/.bashrc
export HH_CONFIG=hicolor         # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
export PROMPT_COMMAND="history -a; history -c; history -r; ${PROMPT_COMMAND}"   # mem/file sync
bind '"\C-r": "\C-a hh \C-j"'    # bind hh to Ctrl-r

