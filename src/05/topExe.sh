#!/bin/bash                                                                     

function topExe()
{
out="$(find "$1" -type f -executable -not -path '*/\.*' -exec du -h {} + 2>/dev/null | sort -hr | head -n 10 )"
IFS=$'\n'
count=0
for var in $out
do
    (( count += 1 ))
    path=$(echo "$var" | awk '{print $2}')
    size=$(echo "$var" | awk '{print $1}' | sed -e 's:K: Kb:g' | sed 's:M: Mb:g' | sed 's:G: Gb:g' )
    md5=$(md5sum "$path" | awk '{print $1}')
    printf "%d - %s, %s, %s\n" $count "$path" "$size" "$md5"
done
}

