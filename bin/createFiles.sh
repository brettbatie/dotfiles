#! /bin/bash
#dd if=/dev/urandom bs=1024 count=10240 | split -a 4 -b 1k - file.
for n in {1..100000}; do
    dd if=/dev/urandom of=file$( printf %03d "$n" ).bin bs=1 count=$(( ( RANDOM % 10 )  + 1 ))
done
