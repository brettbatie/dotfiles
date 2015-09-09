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
getSS(){
    apiRequest GET https://api.smartsheet.com/1.1 $@
}
postSS(){
    apiRequest POST https://api.smartsheet.com/1.1 $@
}
putSS(){
    apiRequest PUT https://api.smartsheet.com/1.1 $@
}
deleteSS(){
    apiRequest DELETE https://api.smartsheet.com/1.1 $@
}
getSSV2(){
    apiRequest GET https://api.smartsheet.com/2.0 $@
}
postSSV2(){
    apiRequest POST https://api.smartsheet.com/2.0 $@
}
putSSV2(){
    apiRequest PUT https://api.smartsheet.com/2.0 $@
}
deleteSSV2(){
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
getJiraWebhook(){
  curl -s -X GET -H "Authorization: Basic $jiraToken" -H "Content-Type: application/json" "http://ec2-52-88-140-61.us-west-2.compute.amazonaws.com:8080/rest/api/webhooks/1.0/webhook/$1" | pp
}

