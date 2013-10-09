# Add dotfile binaries to path
export PATH=$HOME/dotfiles/bin:$PATH



# source all files in dotfiles or only the given file
function src() {
  local file
  if [[ "$1" ]]; then
    source "$HOME/dotfiles/source/$1.sh"
  else
    for file in ~/dotfiles/source/*; do
      source "$file"
    done
  fi
}

src
