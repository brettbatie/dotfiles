# Set the default editor based on what is installed on the system
if hash subl >/dev/null 2>&1; then
    export EDITOR='subl -w'
elif hash vim >/dev/null 2>&1; then
    export EDITOR='vim'
elif hash vi >/dev/null 2>&1; then
    export EDITOR='vi'
fi
export VISUAL=$EDITOR


# History  settings
export HISTTIMEFORMAT="[%F %T] "
export HISTSIZE=10000
export HISTFILESIZE=10000