#!/bin/bash                                                                                                  

function setBG() {
  if [[ $1 -eq 1 ]]; then
    eval "$2='$whiteBG'"
  elif [[ $1 -eq 2 ]]; then
    eval "$2='$redBG'"
  elif [[ $1 -eq 3 ]]; then
    eval "$2='$greenBG'"
  elif [[ $1 -eq 4 ]]; then
    eval "$2='$blueBG'"
  elif [[ $1 -eq 5 ]]; then
    eval "$2='$purpleBG'"
  elif [[ $1 -eq 6 ]]; then
    eval "$2='$blackBG'"
  fi  
}

function setF() {
  if [[ $1 -eq 1 ]]; then
    eval "$2='$whiteF'"
  elif [[ $1 -eq 2 ]]; then
    eval "$2='$redF'"
  elif [[ $1 -eq 3 ]]; then
    eval "$2='$greenF'"
  elif [[ $1 -eq 4 ]]; then
    eval "$2='$blueF'"
  elif [[ $1 -eq 5 ]]; then
    eval "$2='$purpleF'"
  elif [[ $1 -eq 6 ]]; then
    eval "$2='$blackF'"
  fi  
}