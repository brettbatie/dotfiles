# Easier navigation: .., ...
alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."


# IP info
alias wanip="dig +short myip.opendns.com @resolver1.opendns.com"
alias myip="wanip"

# List Directories
alias lsd="ls -ld .*/"

# -E Keep current environment when doing a sudo
# Space at end allows alias expansion after sudo (ex sudo ll)

alias sudo="sudo -E "

alias psql="sudo -u postgres psql"

alias chromium_domain="chromium --auth-server-whitelist='*.smartsheet.com'"

alias herokuSqlDev="heroku pg:psql --app smartsheet-labs-dev"
alias herokuSqlProd="heroku pg:psql --app smartsheet-labs-prod"
alias xclip="xclip -selection c"

alias gitgrep="git rev-list --all | xargs git grep"
alias sf="force"
alias android_emulator="~/android-sdks/tools/./android avd"
alias battery="acpi -bi"

alias ss-start="(cd ~/git/core/dev2 && vagrant up)"
alias ss-stop="(cd ~/git/core/dev2 && vagrant halt)"
alias labs-start="screen -dmS labs bash -c \"(cd ~/git/platform-labs && play '~run -Dhttp.port=9001'); exec bash\""
alias labs-stop="pkill -f /opt/play-2.2.1/play;  screen -X -S labs"
alias herokuDevPush="git push heroku-dev-2 release-1.3:master"
alias herokuProdPush="git push heroku-prod release-1.3:master"
alias pp="python -mjson.tool"
alias ssLogin='kinit -p bbatie@APOLLO.SMARTSHEET.COM;klist'
alias gitBranchAuthor='git for-each-ref --format="%(committerdate) %09 %(authorname) %09 %(refname)" | sort -k5n -k2M -k3n -k4n'
alias gcal='gcalcli'
#alias google-chrome='google-chrome --disable-new-avatar-menu'
alias menu-shortcut='exo-desktop-item-edit --create-new ~/.local/share/applications'
