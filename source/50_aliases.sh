# Easier navigation: .., ...
alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias v=vim
alias s=subl

# determine keyboard key codes
alias xevBetter_="xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'"


# IP info
alias wanIP_="dig +short myip.opendns.com @resolver1.opendns.com"
alias myIP_="wanip"
alias netstatPort_="netstat -tulpne"

# List Directories
alias lsd="ls -ld .*/"

# -E Keep current environment when doing a sudo
# Space at end allows alias expansion after sudo (ex sudo ll)
alias sudo="sudo -E "

alias aptInstalled_="aptitude search '~i!~M'"
alias psql_="sudo -u postgres psql"

alias herokuSqlDev_="heroku pg:psql --app smartsheet-labs-dev"
alias herokuSqlProd_="heroku pg:psql --app smartsheet-labs-prod"
alias xclip="xclip -selection c"

# Search git history for a line that changed with a specific word
alias gitGrepHistory_="git rev-list --all | xargs git grep"
# Search git history for a line that changed with a specific word and show the commit info
alias gitGrepHistoryShowLog_="git log -SVersionManager"
alias androidEmulator="~/android-sdks/tools/./android avd"
alias battery_="acpi -bi"

alias pp_="python -mjson.tool"
alias gCal_='gcalcli'
alias menuShortcut_='exo-desktop-item-edit --create-new ~/.local/share/applications'

#docker
alias dockerStopAll_='echo "About to stop all docker instances." && confirm && docker stop $(docker ps -q)'
alias dockerKillAll_='echo "About to stop all docker instances." && confirm && docker kill $(docker ps -q)'
alias dockerRemoveAll_='echo "About to remove all docker containers." && confirm && docker rm -f $(docker ps -a -q);  echo "About to remove all docker images" && confirm && docker rmi -f $(docker images -q) '
alias dockerStats_='docker stats $(docker ps --format={{.Names}})'
alias dockerPS_='docker ps --format "table {{.Names}}\t{{.ID}}\t{{.Status}}\t{{.CreatedAt}}"'

#GIT
alias gitBranch_="git branch -avv"
alias gitBranchAuthor='git for-each-ref --format="%(committerdate) %09 %(authorname) %09 %(refname)" | sort -k5n -k2M -k3n -k4n'
