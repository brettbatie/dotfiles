#!/bin/bash
# usage getSlowQueryLog.sh my-db-1 '2020-07-18'
instanceID=$1
date=$2

function downloadLog () {
  local log=$1

  aws rds download-db-log-file-portion \
    --output text \
    --db-instance-identifier $instanceID \
    --log-file-name $log \
    --region us-east-1
}

downloadLog slowquery/mysql-slowquery.log > slow-$date.log

for i in {1..23}; do
  downloadLog slowquery/mysql-slowquery.log.$i >> slow-$date.log
done