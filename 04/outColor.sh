#!/bin/bash                                                                                                  

source config.txt

function outputColor() {
  color-handler $FG1 FG1T;
  color-handler $FG2 FG2T;
  color-handler $BG1 BG1T;
  color-handler $BG2 BG2T;
  
  if [[ $1 = "default" ]]; then
    column1_background=default
    column1_font_color=default
    column2_background=default
    column2_font_color=default
  fi  
  echo "Column 1 background = $column1_background ($BG1T)"
  echo "Column 1 font color = $column1_font_color ($FG1T)"
  echo "Column 2 background = $column2_background ($BG2T)"
  echo "Column 2 font color = $column2_font_color ($FG2T)"
  }
  
  function color-handler() {
  if [[ $1 = "$whiteF" ]] || [[ $1 = "$whiteBG" ]]; then
    eval "$2='white'"
  elif [[ $1 = "$redF" ]] || [[ $1 = "$redBG" ]]; then
    eval "$2='red'"
  elif [[ $1 = "$greenF" ]] || [[ $1 = "$greenBG" ]]; then
    eval "$2='green'"
  elif [[ $1 = "$blueF" ]] || [[ $1 = "$blueBG" ]]; then
    eval "$2='blue'"
  elif [[ $1 = "$purpleF" ]] || [[ $1 = "$purpleBG" ]]; then
    eval "$2='purple'"
  elif [[ $1 = "$blackF" ]] || [[ $1 = "$blackBG" ]]; then
    eval "$2='black'"
  fi  
}