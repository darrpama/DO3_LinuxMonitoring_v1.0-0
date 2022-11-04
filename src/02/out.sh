#!/bin/bash

function output()
{
hostname=$HOSTNAME
timezone=`timedatectl | awk ' /Time zone/{print $3" "$4" "$5}'`
user=`whoami`
OS=`uname -s`
ip=(`ifconfig | awk ' /inet /{print $2} ' | xargs`)
mask=(`ifconfig | awk ' /inet /{print $4}' | xargs`)
gateway=`ip r | grep 'default via' | awk '{print $3}' | xargs`
ramTotal=`free -m | grep Mem | awk '{printf "%.3f\n", $2 / 1024}'`
ramUsed=`free -m | grep Mem | awk '{printf "%.3f\n", $3 / 1024}'`
ramFree=`free -m | grep Mem | awk '{printf "%.3f\n", $4 / 1024}'`
spaceRoot=`df -hk | grep "\/$" | awk '{printf "%.2f\n", $2 / 1024}'`
spaceRootUsed=`df -hk | grep "\/$" | awk '{printf "%.2f\n", $3 / 1024}'`
spaceRootFree=`df -hk | grep "\/$" | awk '{printf "%.2f\n", $4 / 1024}'`
echo "hostname          = $hostname"
echo "timezone          = $timezone"
echo "user              = $user"
echo "OS                = $OS"
###
echo -n "ip                = "
for (( i = 0; i < ${#ip[*]} ; i++ ))
do
	echo -n "${ip[i]} "
done
echo -e""

echo -n "mask              = "
for (( i = 0; i < ${#mask[*]} ; i++ ))
do
	echo -n "${mask[i]} "
done
echo -e""
###
echo "gateway           = $gateway"
echo "Ram total         = $ramTotal Gb"
echo "Ram used          = $ramUsed Gb"
echo "Ram free          = $ramFree Gb"
echo "Space root        = $spaceRoot Mb"
echo "Space root used   = $spaceRootUsed Mb"
echo "Space root free   = $spaceRootFree Mb"
}

