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

# if this is interactive shell, then bind hh to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hh \C-j"'; fi

export M3_HOME=/opt/apache-maven-3.2.3/
export M3=$M3_HOME/bin
export PATH=$M3:$PATH
#export JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64/
#export PATH=$JAVA_HOME/bin:$PATH
export PATH=$PATH:/opt/play-2.2.1

#Used for google drive - http://xmodulo.com/2013/10/mount-google-drive-linux.html
export PATH=$PATH:/home/brett/.opam/system/bin

# Go
export PATH=$PATH:/usr/local/go/bin
export GOPATH=~/.go

# HACK for mavins mate
# export PYTHONWARNINGS="ignore"

# User bin
export PATH=$PATH:/home/brett/bin

# Activator
export PATH=$PATH:/opt/activator

#IntelliJ
export PATH=$PATH:/opt/idea/bin

# NODE
#export PATH=$PATH:/opt/node/bin

# PIP
export PY_USER_BIN=$(python -c 'import site; print(site.USER_BASE + "/bin")')
export PATH=$PY_USER_BIN:$PATH

# RUBY
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
