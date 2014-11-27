#!/bin/sh

localsha=`git show HEAD^:$1 | sha1sum`
remotesha=`cat $1 | sha1sum`

if [ X"$localsha" = X"$remotesha" ]; then
    a="b"
else
    echo "DIFFERENT $1"
fi

