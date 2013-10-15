export DOT_FILES=$HOME/dotfiles
export EDITOR='subl -w'
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

# Offers to install applications (not already installed) from a given list
installApps() {
    if [ $# -eq 0 ]; then
        echo "usage: installApps appName.list"
        echo "appName.list the list to use in the \$DOT_FILES/custom/ directory."
        
        echo -e "\nSpecify the name for this application list."

        echo -e "\nApplication lists in $DOT_FILES/custom/ are:\n"
        ls $DOT_FILES/custom/*.list |xargs basename
        return;
    fi

    appList=$DOT_FILES/custom/$1
    if [[ ! $appList =~ ^.*\.list$ ]]; then
        appList="$appList.list"
    fi

    if [ ! -f $appList ]; then
        echo "$appList does not exist please run the setApps $1 command to create it."
        return
    fi

    echo -e "Apps Not Installed On This System\n================================="
    apps=$(diff -y --left-column --suppress-common-lines <(cat $appList | sed -r 's/i\s+([^ ]+).*/\1/g') <(aptitude search '~i!~M' | sed -r 's/i\s+([^ ]+).*/\1/g') | grep -vE '^\s+>.*$' | sed -r 's/<//g')
    echo $apps

    echo -e "\n"
    read -p "Install the above applications [y/n]?" -n 1 -r
    # if not yes, then skip it
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo aptitude install $apps
    fi
}


# Gets a list of all of the applications installed on this computer and saves it to a file
setApps() {
    if [ $# -eq 0 ]; then
        echo "usage: setApps appName.list"
        echo "appName.list will create the specified file in the \$DOT_FILES/custom/ directory."
        
        echo -e "\nSpecify the name for this application list."

        echo -e "\nApplication lists in $DOT_FILES/custom/ are:\n"
        ls $DOT_FILES/custom/*.list |xargs basename
        return;
    fi

    # support for both appName and appName.list
    appList="$DOT_FILES/custom/$1"
    if [[ ! $appList =~ ^.*\.list$ ]]; then
        appList="$appList.list"
    fi

    if [ -f $appList ]; then
        read -p "Overwrite the apps list ($appList) [y/n]?" -n 1 -r
    fi
    
    if [[ $REPLY =~ ^[Yy]$ ]] || [ "$REPLY" == "" ]; then
        aptitude search '~i!~M' > $appList
        echo -e "\n\nFinished creating list of installed application at $appList."
    fi
}