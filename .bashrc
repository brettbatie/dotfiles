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

function src() {
  local file
  if [[ "$1" ]]; then
    source "$HOME/dotfiles-private/source/$1.sh"
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
if [ -t 1 ]
then
    bind '"\C-r": "\C-a hh \C-j"'    # bind hh to Ctrl-r
fi




#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/brett/.sdkman"
[[ -s "/home/brett/.sdkman/bin/sdkman-init.sh" ]] && source "/home/brett/.sdkman/bin/sdkman-init.sh"

# add this configuration to ~/.bashrc
export HH_CONFIG=hicolor         # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"   # mem/file sync
# if this is interactive shell, then bind hh to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hh -- \C-j"'; fi
# if this is interactive shell, then bind 'kill last command' to Ctrl-x k
if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hh -k \C-j"'; fi


complete -C /home/brett/dotfiles/bin/terraform terraform

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
