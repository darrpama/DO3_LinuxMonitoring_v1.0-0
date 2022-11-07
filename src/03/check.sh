#!/bin/bash                                                                                                  

function check() {
  if [[ $# = 4 ]]; then
    for i in "$@"; do
      if [[ i -lt 1 ]] || [[ i -gt 6 ]]; then
        err "Входные параметры: [1-6] [1-6] [1-6] [1-6]"
        exit 1
      fi  
    done
    colorCheck "$@"
  else
    err "Входные параметры: [1-6] [1-6] [1-6] [1-6]"
    exit 1
  fi  
}

function colorCheck() {
  if [[ "$1" = "$2" ]] || [[ "$3" = "$4" ]]; then
    err "Цвет фона должен отличаться от цвета шрифта"
    exit 1
  else
    setBG "$1" BG1 
    setBG "$3" BG2 
    setF "$2" FG1 
    setF "$4" FG2 
    output
  fi  
}