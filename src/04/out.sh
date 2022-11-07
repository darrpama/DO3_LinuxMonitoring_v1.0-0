#!/bin/bash                                                                                                  

function outputColor() {
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
  echo -e "${BG1}${FG1}hostname${NORMAL}          = ${BG2}${FG2}$hostname${NORMAL}"
  echo -e "${BG1}${FG1}timezone${NORMAL}          = ${BG2}${FG2}$timezone${NORMAL}"
  echo -e "${BG1}${FG1}user${NORMAL}              = ${BG2}${FG2}$user${NORMAL}"
  echo -e "${BG1}${FG1}OS${NORMAL}                = ${BG2}${FG2}$OS${NORMAL}"
  ### 
  echo -n -e "${BG1}${FG1}ip${NORMAL}                = "
  for (( i = 0; i < ${#ip[*]} ; i++ )); do
    echo -n -e "${BG2}${FG2}${ip[i]} "
  done
  echo -e "${NORMAL}"
  
  echo -n -e "${BG1}${FG1}mask${NORMAL}              = "
  for (( i = 0; i < ${#mask[*]} ; i++ )); do
    echo -n -e "${BG2}${FG2}${mask[i]} "
  done
  echo -e "${NORMAL}"
  ### 
  echo -e "${BG1}${FG1}gateway${NORMAL}           = ${BG2}${FG2}$gateway${NORMAL}"
  echo -e "${BG1}${FG1}Ram total${NORMAL}         = ${BG2}${FG2}$ramTotal Gb${NORMAL}"
  echo -e "${BG1}${FG1}Ram used${NORMAL}          = ${BG2}${FG2}$ramUsed Gb${NORMAL}"
  echo -e "${BG1}${FG1}Ram free${NORMAL}          = ${BG2}${FG2}$ramFree Gb${NORMAL}"
  echo -e "${BG1}${FG1}Space root${NORMAL}        = ${BG2}${FG2}$spaceRoot Mb${NORMAL}"
  echo -e "${BG1}${FG1}Space root used${NORMAL}   = ${BG2}${FG2}$spaceRootUsed Mb${NORMAL}"
  echo -e "${BG1}${FG1}Space root free${NORMAL}   = ${BG2}${FG2}$spaceRootFree Mb${NORMAL}"
}
