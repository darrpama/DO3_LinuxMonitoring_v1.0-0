#!/bin/bash
if [ $# -eq 1 ]
then
	check=$(echo "$1" | grep -E "^\-?[0-9]*\.?[0-9]+$")
	if [ "$check" != '' ]
	then
		echo "aboba"
	else
		echo "not aboba"
	fi
else
	echo "There is not 1 param"
fi
