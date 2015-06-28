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

# Function to help send quick requests to Smartsheet
GETSS(){
    if [ "$#" -gt 1 ]; then
        echo 'Usage: GETSS URL_ENDPOINT TOKEN'
        return 1;
    fi
    if [ "$sstoken" == "" ]; then
        sstoken="$2";
    fi
    lwp-request -m GET -H "Authorization: Bearer $sstoken" https://api.smartsheet.com/1.1/$1 | pp
}
POSTSS(){
    if [ "$#" -gt 1 ]; then
        echo 'Usage: GETSS URL_ENDPOINT TOKEN'
        return 1;
    fi
    if [ "$sstoken" == "" ]; then
        sstoken="$2";
    fi
    lwp-request -c application/json -m POST -H "Authorization: Bearer $sstoken" https://api.smartsheet.com/1.1/$1 | pp
}
PUTSS(){
    if [ "$#" -gt 1 ]; then
        echo 'Usage: GETSS URL_ENDPOINT TOKEN'
        return 1;
    fi
    if [ "$sstoken" == "" ]; then
        sstoken="$2";
    fi
    lwp-request -c application/json -m PUT -H "Authorization: Bearer $sstoken" https://api.smartsheet.com/1.1/$1 | pp
}
DELETESS(){
    if [ "$#" -gt 1 ]; then
        echo 'Usage: GETSS URL_ENDPOINT TOKEN'
        return 1;
    fi
    if [ "$sstoken" == "" ]; then
        sstoken="$2";
    fi
    lwp-request -c application/json -m DELETE -H "Authorization: Bearer $sstoken" https://api.smartsheet.com/1.1/$1 | pp
}
GETSSV2(){
    if [ "$#" -gt 1 ]; then
        echo 'Usage: GETSS URL_ENDPOINT TOKEN'
        return 1;
    fi
    if [ "$sstoken" == "" ]; then
        sstoken="$2";
    fi
    lwp-request -m GET -H "Authorization: Bearer $sstoken" https://api.smartsheet.com/2.0/$1 | pp
}
POSTSSV2(){
    if [ "$#" -gt 1 ]; then
        echo 'Usage: GETSS URL_ENDPOINT TOKEN'
        return 1;
    fi
    if [ "$sstoken" == "" ]; then
        sstoken="$2";
    fi
    lwp-request -c application/json -m POST -H "Authorization: Bearer $sstoken" https://api.smartsheet.com/2.0/$1 | pp
}
PUTSSV2(){
    if [ "$#" -gt 1 ]; then
        echo 'Usage: GETSS URL_ENDPOINT TOKEN'
        return 1;
    fi
    if [ "$sstoken" == "" ]; then
        sstoken="$2";
    fi
    lwp-request -c application/json -m PUT -H "Authorization: Bearer $sstoken" https://api.smartsheet.com/2.0/$1 | pp
}
DELETESSV2(){
    if [ "$#" -gt 1 ]; then
        echo 'Usage: GETSS URL_ENDPOINT TOKEN'
        return 1;
    fi
    if [ "$sstoken" == "" ]; then
        sstoken="$2";
    fi
    lwp-request -c application/json -m DELETE -H "Authorization: Bearer $sstoken" https://api.smartsheet.com/2.0/$1 | pp
}