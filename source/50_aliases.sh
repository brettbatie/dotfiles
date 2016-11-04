# Easier navigation: .., ...
alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."


# IP info
alias wanip="dig +short myip.opendns.com @resolver1.opendns.com"
alias myip="wanip"
alias netstat-port="netstat -tulpne"

# List Directories
alias lsd="ls -ld .*/"

# -E Keep current environment when doing a sudo
# Space at end allows alias expansion after sudo (ex sudo ll)

alias sudo="sudo -E "
alias aptInstalled="aptitude search '~i!~M'"

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
alias gitBranchAuthor='git for-each-ref --format="%(committerdate) %09 %(authorname) %09 %(refname)" | sort -k5n -k2M -k3n -k4n'
alias gcal='gcalcli'
#alias google-chrome='google-chrome --disable-new-avatar-menu'
alias menu-shortcut='exo-desktop-item-edit --create-new ~/.local/share/applications'

#docker
alias docker-jiralog='docker logs --tail 100 -f jiraplay'
alias docker-jiramysql='docker exec -it jiramysql bash'
alias docker-jiramq='docker exec -it jiramq bash'
alias jiramysql='mysql -h 127.0.0.1 -uroot -p1011 -P3308'
alias docker-jiraplaybackground='docker exec -it jiraplaybackground bash'
alias dockerKillAll='echo "About to stop all docker instances." && confirm && docker kill $(docker ps -q)'
alias dockerStopAll='echo "About to stop all docker instances." && confirm && docker stop $(docker ps -q)'
alias dockerRemoveAll='echo "About to remove all docker containers." && confirm && docker rm -f $(docker ps -a -q);  echo "About to remove all docker images" && confirm && docker rmi -f $(docker images -q) '
alias dockerClean='docker rmi $(docker images -f "dangling=true" -q)'
alias dockerStats='docker stats $(docker ps --format={{.Names}})'
alias dockerUpdate=dockerUpdate
#GIT
alias git-branch="git branch -avv"
