#!/bin/bash                                                                     

source output.sh
source topDir.sh
source topFile.sh
source topExe.sh
source ../01/err.sh

function check() {
  if [ $# -eq 1 ]; then
    if [[ $1 =~ /$ ]]; then
      if [[ -d "$1" ]]; then
        output "$1"
      else
        err "Нет такой директории"
        exit 1
      fi
    else
      err "Введите директорию (путь должен заканчиваться на '/')"
      exit 1
    fi
  else
    err "Должен быть один параметр"
    exit 1
  fi
}

check "$@"
