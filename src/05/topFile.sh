#!/bin/bash                                                                     

function topFile()
{
out="$(find "$1" -type f -not -path '*/\.*' -exec du -h {} + 2>/dev/null | sort -hr | head -n 10 )"
IFS=$'\n'
count=0
for var in $out
do
    (( count += 1 ))
    file=$(echo "$var" | awk '{print $2}')
    size=$(echo "$var" | awk '{print $1}' | sed -e 's:K: Kb:g' | sed 's:M: Mb:g' | sed 's:G: Gb:g' )
    type=$(echo "$var" | awk '{ tp=split($2,type,".") ; print type[tp] }' )
    printf "%d - %s, %s, %s\n" $count "$file" "$size" "$type"
done
}
