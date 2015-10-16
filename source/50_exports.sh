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
export HISTSIZE=1000000
export HISTFILESIZE=1000000

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
