#!/usr/bin/env bash

WD=/tmp/aws-logs/

#if [[ -n $1 ]]; then
mkdir -p $WD
cd $WD
pwd
aws s3 sync s3://cleandrive-request-logs/logs/ .
  cat *.gz > combined.log.gz
  find $WD ! -name 'combined.log.gz' -name '*.gz' -type f -exec rm -f {} +
  gzip -d combined.log.gz
  sed -i '/^#/ d' combined.log
  echo "logs at: $WD"
  exit 0
#else
#  echo "Error: no bucket name provided"
#  exit 1
#fi
