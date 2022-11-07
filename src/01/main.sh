#!/bin/bash
#
# There is script witch takes one text parameter, not number

source err.sh

if [ $# -eq 1 ]
then
	check=$(echo "$1" | grep -E "^\-?[0-9]*\.?[0-9]+$")
	if [ "$check" != '' ]
	then
		err "Скрипт принимает только один текстовый параметр"
		exit 1
	else
		echo "Всё отлично"
	fi
else
	err "Скрипт принимает только один текстовый параметр"
	exit 1
fi
