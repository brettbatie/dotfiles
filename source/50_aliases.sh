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
alias xclip="xclip -selection c"

alias gitgrep="git rev-list --all | xargs git grep"
