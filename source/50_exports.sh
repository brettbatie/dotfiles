# Set the default editor based on what is installed on the system
#if hash subl >/dev/null 2>&1; then
#    export EDITOR='subl -w'
if hash vim >/dev/null 2>&1; then
    export EDITOR='vim'
elif hash vi >/dev/null 2>&1; then
    export EDITOR='vi'
fi

if [ -z "$DISPLAY" ]; then
    export EDITOR='vim'
fi

export VISUAL=$EDITOR


# History  settings
export HISTTIMEFORMAT="[%F %T] "
export HH_CONFIG=hicolor         # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"   # mem/file sync
# if this is interactive shell, then bind hh to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hh \C-j"'; fi

export M3_HOME=/opt/apache-maven-3.2.3/
export M3=$M3_HOME/bin
export PATH=$M3:$PATH
#export JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64/
#export PATH=$JAVA_HOME/bin:$PATH
export PATH=$PATH:/opt/play-2.2.1

#Used for google drive - http://xmodulo.com/2013/10/mount-google-drive-linux.html
export PATH=$PATH:~/.opam/system/bin

# Go
export PATH=$PATH:/usr/local/go/bin
export GOPATH=~/.go

# HACK for mavins mate
# export PYTHONWARNINGS="ignore"

# User bin
export PATH=$PATH:~/bin

# Activator
export PATH=$PATH:/opt/activator

#IntelliJ
export PATH=$PATH:/opt/idea/bin
