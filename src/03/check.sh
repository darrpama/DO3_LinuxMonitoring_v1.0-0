#!/bin/bash

function check()
{
err=0;
if [[ $# = 4 ]]
then
	for i in "$@"
	do
		if [[ i -lt 1] || [ i -gt 6]]
		then
			err=1;
			echo "Input params: [1-6] [1-6] [1-6] [1-6]"
			exit 1
		fi
	done
	if [[ $err = 0 ]]
	then colorCheck "$@"
	else
		exit 1
	fi
else
	echo "Input params: [1-6] [1-6] [1-6] [1-6]"
	exit 1
fi
}
