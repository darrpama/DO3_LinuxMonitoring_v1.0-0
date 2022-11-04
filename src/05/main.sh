#!/bin/bash                                                                     

source output.sh
source topDir.sh
source topFile.sh
source topExe.sh

function check()
{
if [ $# -eq 1 ]
then
    if [[ $1 =~ /$ ]]
    then
        if [[ -d "$1" ]]
        then
            output "$1"
        else
            echo "Нет такой директории"
        fi
    else
        echo "Введите директорию (путь должен заканчиваться на '/')"
        exit 1
    fi
else
    echo "Должен быть один параметр"
    exit 1
fi
}

check "$@"
