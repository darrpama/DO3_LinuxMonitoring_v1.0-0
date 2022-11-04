#!/bin/bash                                                                                                           

function output()
{
startTime=`date +%s%N`
dirNum=`find "$1" -type d | wc -l`
echo "Total number of folders (including all nested ones) = $((dirNum-1))"
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
topDir "$1"
echo "etc up to 5"
echo "Total number of files = "`find "$1" -type f | wc -l`""

echo "Number of:"
echo "Configuration files (with the .conf extension) = "`find "$1" -name "*.conf" | wc -l`""
echo "Text files = "`find "$1" -name "*.txt" | wc -l`""
echo "Executable files = "`find "$1" -type f -executable | wc -l`""
echo "Log files (with the extension .log) = "`find "$1" -name "*.log" | wc -l`""
echo "Archive files = "`find "$1" -name "*.tar"| wc -l`""
echo "Symolic links = "`find "$1" -type l | wc -l`""
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
topFile "$1"
echo "etc up to 10"
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
topExe "$1"
echo "etc up to 10"
endTime=$(date +%s%N)
diffms=$((($endTime - $startTime)/1000000))
diffs=$(($diffms/1000))
echo "Script execution time (in seconds) = $diffs.$diffms"            
}
