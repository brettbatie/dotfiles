#/bin/bash
reset=`tput sgr0`
bold=`tput bold`

#Would be cool to extend this and compare the # lines added vs total contribution still in head and determine percentage of kept code

function printLinesContributedForAllUsers {
	IFS=$'\n'       # make newlines the only separator
	for name in `git log --format='%aN' | sort -u`; do
    	printf "$bold$name:$reset "
    	#stolen from: http://codeimpossible.com/2011/12/16/Stupid-Git-Trick-getting-contributor-stats/
		git grep --cached -Il ''| xargs -n1 -d'\n' -i git log --author="$name" "$@" --pretty=tformat: --numstat {} | \
#			grep -v public/javascripts/jquery | \
			gawk '{ add += $1 ; subs += $2 ; loc += $1 - $2 } END \
			{ printf "added lines: \033[1;32m%s\033[0m removed lines : \033[1;31m%s\033[0m total lines: \033[1;34m%s\033[0m\n",add,subs,loc }' -
	done;
}

function printLinesPerAuthorStillExists {
	git grep --cached -Il '' | xargs -n1 -d'\n' -i git blame {} | perl -n -e '/\s\((.*?)\s[0-9]{4}/ && print "$1\n"' | sort -f | uniq -c -w5 | sort -nr
}

echo 'Note: this does not count binary files'
echo
echo "$boldTotal Lines Contributed to Repo:$normal"
echo "--------------------------------------------"
printLinesContributedForAllUsers
echo
echo
echo "$boldLines Contributed in last three month"
echo "------------------------------------------"
printLinesContributedForAllUsers --since "3 month ago"
echo
echo
echo "$boldLines Contributed in last month"
echo "------------------------------------------"
printLinesContributedForAllUsers --since "1 month ago"
echo
echo
echo "$boldTotal Lines Contributed in last week"
echo "-----------------------------------------"
printLinesContributedForAllUsers --since "2 weeks ago"
echo
echo
echo "$bold Contribution per author with code that still exists in head"
echo "----------------------------------------------------------------"
printLinesPerAuthorStillExists