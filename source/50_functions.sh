#From: http://stackoverflow.com/a/10660730/1608110
urlEncode_() {
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
urlDecode_() {

  # This is perhaps a risky gambit, but since all escape characters must be
  # encoded, we can replace %NN with \xNN and pass the lot to printf -b, which
  # will decode hex for us

  printf -v REPLY '%b' "${1//%/\\x}" # You can either set a return variable (FASTER)

  echo "${REPLY}"  #+or echo the result (EASIER)... or both... :p
}


function apiRequest(){
    if [ "$#" -ne 3 -a "$#" -ne 4 ]; then
        printf "Usage: GETSS GET|POST|PUT|DELETE URL_ENDPOINT [TOKEN]\nUses the environment variables ssToken and ssTokenTest if they are set.\n";
        return 1;
    fi
    
    if [[ ${FUNCNAME[1]} =~ Test_$ ]]; then
        # If calling *Test function and ssTokenTest environment variable is set it will use that.
        ssTokenTmp=$ssTokenTest;
    elif [[ ${FUNCNAME[1]} =~ Local_$ ]]; then
        ssTokenTmp=$ssTokenLocal;
    else
        ssTokenTmp=$ssToken;
    fi

    if [ -n "$4" ]; then
        # If the $ssToken environment variable is set it will use that.
        ssTokenTmp="$4";
    fi

    contentType="";
    if [ "$1" == "PUT" -o "$1" == "POST" ]; then
        curl -s -X $1 -H "Authorization: Bearer $ssTokenTmp" -H "Content-Type: application/json" -d @- ${2%"/"}/${3#"/"} | jq '.'
    else
        curl -s -X $1 -H "Authorization: Bearer $ssTokenTmp" ${2%"/"}/${3#"/"} | jq '.'
    fi
    
    echo "Requesting ${2%"/"}/${3#"/"}" 1>&2;
    #lwp-request $contentType -m $1 -H "Authorization: Bearer $ssTokenTmp" ${2%"/"}/${3#"/"} | jq
    
    
}

# Function to help send quick requests to Smartsheet
getSS_(){
    apiRequest GET https://api.smartsheet.com/2.0 $@
}
postSS_(){
    apiRequest POST https://api.smartsheet.com/2.0 $@
}
putSS_(){
    apiRequest PUT https://api.smartsheet.com/2.0 $@
}
deleteSS_(){
    apiRequest DELETE https://api.smartsheet.com/2.0 $@
}
getSSTest_(){
    apiRequest GET https://api.test.smartsheet.com/2.0 $@
}
postSSTest_(){
    apiRequest POST https://api.test.smartsheet.com/2.0 $@
}
putSSTest_(){
    apiRequest PUT https://api.test.smartsheet.com/2.0 $@
}
deleteSSTest_(){
    apiRequest DELETE https://brett.lab.smartsheet.com/2.0 $@
}
getSSLocal_(){
    apiRequest GET https://brett.lab.smartsheet.com/develop/rest/2.0 $@
}
postSSLocal_(){
    apiRequest POST https://brett.lab.smartsheet.com/develop/rest/2.0 $@
}
putSSLocal_(){
    apiRequest PUT https://brett.lab.smartsheet.com/develop/rest/2.0 $@
}
deleteSSLocal_(){
  apiRequest DELETE https://brett.lab.smartsheet.com/develop/rest/2.0 $@
}
   


function exifStrip_(){
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


function confirm_() {
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

gitMerge() {
    branchA="$(git branch | grep '*' | sed 's/* //g')"
    if [ "$#" -ne 1 ]; then
        printf "Usage: $FUNCNAME branchToMerge\nWill checkout the specified branch, pull it and come back to $branchA and then merge.\n";
        return 1;
    fi
    branchB=$1
    if [ "$branchB" == "$branchA" ]; then
        printf "The specified branch name is the same as the current branch."
        return 1;
    fi
    inside_git_repo="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
    if [ "$inside_git_repo" ]; then
      git checkout ${branchB} && git pull
      git checkout ${branchA} && git merge ${branchB}
    else
      printf "not in git repo"
    fi
}

function gitDeleteMergedBranches_ () {
  echo && \
  echo "Branches that are already merged into $(git rev-parse --abbrev-ref HEAD) and will be deleted from both local and remote:" && \
  echo && \
  git branch --merged | grep personal/brettb/ && \
  echo && \
  confirm_ && git branch --merged | grep personal/brettb | xargs -n1 -I '{}' sh -c "git push origin --delete '{}'; git branch -d '{}';"  
}

function gitDeleteBranch_ () {
  if [ "$#" -ne 1 ]; then
      printf "Usage: $FUNCNAME branchName\nWill delete the specified branch from both the local repository and remote\n";
      return 1;
  fi
  echo "Delete the branch '$1' from your local repository?" && confirm_ && git branch -d $1;
  echo "Delete the branch '$1' from the remote repository?" && confirm_ && git push origin --delete $1;
}


function dockerUpdate_ () {
   docker images | awk '(NR>1) && ($2!~/none/) {print $1":"$2}' | xargs -L1 docker pull
}

function dockerConnect_ () {
  if [ -z "$1" ]; then
    echo "Please specify a container name to connect to - i.e. $0 appcoretomcat"
  else
    docker exec -it $1 bash
  fi 
}

function kcurl_() {
    curl --negotiate -u : -b ~/cookiejar.txt -c ~/cookiejar.txt -k $1
}


function pGrep_() {
  ps -ef | { head -1; grep $@; }
}

function bootFreeSpace() {
  echo 'Going to remove the following unused kernels:'
  echo ''
  kernelver=$(uname -r | sed -r 's/-[a-z]+//')
  dpkg -l linux-{image,headers}-"[0-9]*" | awk '/ii/{print $2}' | grep -ve $kernelver

  confirm_ && sudo apt-get purge $(dpkg -l linux-{image,headers}-"[0-9]*" | awk '/ii/{print $2}' | grep -ve "$(uname -r | sed -r 's/-[a-z]+//')")
}