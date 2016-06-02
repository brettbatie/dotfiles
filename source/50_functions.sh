#From: http://stackoverflow.com/a/10660730/1608110
urlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"    # You can either set a return variable (FASTER) 
  REPLY="${encoded}"   #+or echo the result (EASIER)... or both... :p
}


#From: http://stackoverflow.com/a/10660730/1608110
urldecode() {

  # This is perhaps a risky gambit, but since all escape characters must be
  # encoded, we can replace %NN with \xNN and pass the lot to printf -b, which
  # will decode hex for us

  printf -v REPLY '%b' "${1//%/\\x}" # You can either set a return variable (FASTER)

  echo "${REPLY}"  #+or echo the result (EASIER)... or both... :p
}


function apiRequest(){
    if [ "$#" -ne 3 -a "$#" -ne 4 ]; then
        printf "Usage: GETSS URL_ENDPOINT [TOKEN]\nUses the environment variables ssToken and ssTokenTest if they are set.\n";
        return 1;
    fi
    
    if [[ ${FUNCNAME[1]} =~ Test$ ]]; then
        # If calling *Test function and ssTokenTest environment variable is set it will use that.
        ssTokenTmp=$ssTokenTest;
    else
        ssTokenTmp=$ssToken;
    fi

    if [ -n "$4" ]; then
        # If the $ssToken environment variable is set it will use that.
        ssTokenTmp="$4";
    fi

    contentType="";
    if [ "$1" == "PUT" -o "$1" == "POST" ]; then
        echo $ssTokenTmp;
        curl -v -s -X $1 -H "Authorization: Bearer $ssTokenTmp" -H "Content-Type: application/json" -d @- ${2%"/"}/${3#"/"} | pp
    else
        curl -v -s -X $1 -H "Authorization: Bearer $ssTokenTmp" ${2%"/"}/${3#"/"} | pp
    fi
    
    echo "Requesting ${2%"/"}/${3#"/"}";
    #lwp-request $contentType -m $1 -H "Authorization: Bearer $ssTokenTmp" ${2%"/"}/${3#"/"} | pp
    
    
}

# Function to help send quick requests to Smartsheet
getSS1(){
    apiRequest GET https://api.smartsheet.com/1.1 $@
}
postSS1(){
    apiRequest POST https://api.smartsheet.com/1.1 $@
}
putSS1(){
    apiRequest PUT https://api.smartsheet.com/1.1 $@
}
deleteSS1(){
    apiRequest DELETE https://api.smartsheet.com/1.1 $@
}
getSS(){
    apiRequest GET https://api.smartsheet.com/2.0 $@
}
postSS(){
    apiRequest POST https://api.smartsheet.com/2.0 $@
}
putSS(){
    apiRequest PUT https://api.smartsheet.com/2.0 $@
}
deleteSS(){
    apiRequest DELETE https://api.smartsheet.com/2.0 $@
}
getSSTest(){
    apiRequest GET https://api.test.smartsheet.com/2.0 $@
}
postSSTest(){
    apiRequest POST https://api.test.smartsheet.com/2.0 $@
}
putSSTest(){
    apiRequest PUT https://api.test.smartsheet.com/2.0 $@
}
deleteSSTest(){
    apiRequest DELETE https://api.test.smartsheet.com/2.0 $@
}



getJira(){
  curl -s -X GET -H "Authorization: Basic $jiraToken" -H "Content-Type: application/json" "http://ec2-52-88-140-61.us-west-2.compute.amazonaws.com:8080/rest/api/2/$1" | pp
}
putJira(){
  curl -S -X PUT -H "Authorization: Basic $jiraToken" -H "Content-Type: application/json" -d @- "http://ec2-52-88-140-61.us-west-2.compute.amazonaws.com:8080/rest/api/2/$1" 
}

postJira(){
   curl -S -X POST -H "Authorization: Basic $jiraToken" -H "Content-Type: application/json" -d @- "http://ec2-52-88-140-61.us-west-2.compute.amazonaws.com:8080/rest/api/2/$1"·
}

postJiraWebhook(){
   curl -S -X POST -H "Authorization: Basic $jiraToken" -H "Content-Type: application/json" -d @- "http://ec2-52-88-140-61.us-west-2.compute.amazonaws.com:8080/rest/webhooks/1.0/webhook"
}

getJiraWebhook(){
  curl -s -X GET -H "Authorization: Basic $jiraToken" -H "Content-Type: application/json" "http://ec2-52-88-140-61.us-west-2.compute.amazonaws.com:8080/rest/webhooks/1.0/webhook" | pp
}

getJira7(){
  curl -s -X GET -H "Authorization: Basic $jiraToken7" -H "Content-Type: application/json" "https://smartsheet-platform.atlassian.net/rest/api/2/$1" | pp
}
putJira7(){
  curl -S -X PUT -H "Authorization: Basic $jiraToken7" -H "Content-Type: application/json" -d @- "https://smartsheet-platform.atlassian.net/rest/api/2/$1" 
}

postJira7(){
   curl -S -X POST -H "Authorization: Basic $jiraToken7" -H "Content-Type: application/json" -d @- "https://smartsheet-platform.atlassian.net/rest/api/2/$1"·
}

postJiraWebhook7(){
   curl -S -X POST -H "Authorization: Basic $jiraToken7" -H "Content-Type: application/json" -d @- "https://smartsheet-platform.atlassian.net/rest/webhooks/1.0/webhook"
}

getJiraWebhook7(){
  curl -s -X GET -H "Authorization: Basic $jiraToken7" -H "Content-Type: application/json" "https://smartsheet-platform.atlassian.net/rest/webhooks/1.0/webhook" | pp
}

function exifStrip(){
    if [ "$#" -ne 1 ]; then
        printf "Usage: $FUNCNAME fileOrDirectory\nWill delete all exif data from the given file or recursively in the entire directory.\n";
        return 1;
    fi

    read -p "Are you sure you want to remove all the exif data from the specified file or directory? [y/n] " -n 1 -r
	echo    # (optional) move to a new line
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
	    exiftool -all= $1
	fi
}


function confirm () {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure? [y/N]} " response
    case $response in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

function git-delete-merged-branches () {
  echo && \
  echo "Branches that are already merged into $(git rev-parse --abbrev-ref HEAD) and will be deleted from both local and remote:" && \
  echo && \
  git branch --merged | grep feature && \
  echo && \
  confirm && git branch --merged | grep feature | xargs -n1 -I '{}' sh -c "git push origin --delete '{}'; git branch -d '{}';"  
}

function git-delete-branch () {
  if [ "$#" -ne 1 ]; then
      printf "Usage: $FUNCNAME branchName\nWill delete the specified branch from both the local repository and remote\n";
      return 1;
  fi
  echo "Delete the branch '$1' from your local repository?" && confirm && git branch -d $1;
  echo "Delete the branch '$1' from the remote repository?" && confirm && git push origin --delete $1;
}
