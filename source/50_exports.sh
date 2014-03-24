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
export HISTSIZE=10000
export HISTFILESIZE=10000

export M3_HOME=/opt/apache-maven-3.1.1/
export M3=$M3_HOME/bin
export PATH=$M3:$PATH
#export JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64/
#export PATH=$JAVA_HOME/bin:$PATH
export PATH=$PATH:/opt/play-2.2.1

# Settings for Play
export SMARTSHEET_AUTHORIZE_URL="https://brett.lab.smartsheet.com/dev2/authorize"
export SMARTSHEET_CLIENT_ID="av4dkuuo6vwdrd2j7v"
export SMARTSHEET_CLIENT_SECRET="16rn4oelmw5qspij74f"
export SMARTSHEET_REDIRECT_URL="http://brett.play.smartsheet.com:9000/target"
export SMARTSHEET_API_URL="https://brett.lab.smartsheet.com/dev2/rest/1.1/"
export DB_TOKEN_ENCRYPTION_KEY="asdfasdfol"
export CONFIG_FILE="brett.conf"

