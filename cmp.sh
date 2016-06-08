#!/bin/bash
for d in `ls`
do
    if [ -d $d ] && [ -f $d/test.pl ]
    then
        perl cmp.pl $d > $d/result.txt
    fi
done
