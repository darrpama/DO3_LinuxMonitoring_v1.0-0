#!/bin/bash                                                                                                  

source outColor.sh
source out.sh
source check.sh
source ../01/err.sh

whiteF="\033[97m"
redF="\033[31m"
greenF="\033[32m"
blueF="\033[34m"
purpleF="\033[35m"
blackF="\033[30m"

whiteBG="\033[107m"
redBG="\033[41m"
greenBG="\033[42m"
blueBG="\033[44m"
purpleBG="\033[45m"
blackBG="\033[40m"
NORMAL="\033[0m"

BG1=0;
F1=0;
BG2=0;
F2=0;

check-1 "$@"