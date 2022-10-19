#!/bin/bash                                                                     

function topDir()
{
        out=$(du -h "$1" | sort -rh | head -5 | awk '{print " - "$2", "$1 }')
IFS=$'\n'
count=0
for item in $out
do
    (( count += 1 ))
echo "$count $item"
done
}

