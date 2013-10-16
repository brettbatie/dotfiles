# Set the default editor based on what is installed on the system
if hash subl >/dev/null 2>&1; then
    export EDITOR='subl -w'
elif hash vim >/dev/null 2>&1; then
    export EDITOR='vim'
elif hash vi >/dev/null 2>&1; then
    export EDITOR='vi'
fi
export VISUAL=$EDITOR

# Easier navigation: .., ..., -
alias ..='cd ..'
alias ...='cd ../..'
alias -- -='cd -'

# History  settings
export HISTTIMEFORMAT="[%F %T] "
export HISTSIZE=10000
export HISTFILESIZE=10000

alias wanip="dig +short myip.opendns.com @resolver1.opendns.com"
alias myip="wanip"
alias lsd="ls -ld .*/"


#From: http://stackoverflow.com/a/10660730/1608110
urlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"    # You can either set a return variable (FASTER) 
  REPLY="${encoded}"   #+or echo the result (EASIER)... or both... :p
}


#From: http://stackoverflow.com/a/10660730/1608110
urldecode() {

  # This is perhaps a risky gambit, but since all escape characters must be
  # encoded, we can replace %NN with \xNN and pass the lot to printf -b, which
  # will decode hex for us

  printf -v REPLY '%b' "${1//%/\\x}" # You can either set a return variable (FASTER)

  echo "${REPLY}"  #+or echo the result (EASIER)... or both... :p
}

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
    alias "$method"="lwp-request -m '$method'"
done

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

