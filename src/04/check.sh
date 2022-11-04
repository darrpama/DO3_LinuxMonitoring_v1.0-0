#!/bin/bash                                                                                                           

source config.txt
source ./../03/check.sh
source ./../03/color.sh
source ./../03/out.sh
source outColor.sh

function newcheck()
{
if [[ $# = 0 ]]
then
    BG1=$column1_background
    BG2=$column2_background
    FG1=$column1_font_color
    FG2=$column2_font_color

    if [[ -z $BG1 ]] || [[ -z $BG2 ]] || [[ -z $FG1 ]] || [[ -z $FG2 ]]
    then
        BG1=2; BG2=3; FG1=3; FG2=4;
    
        colorCheck $BG1 $FG1 $BG2 $FG2
        echo ""
        outputColor default
    else
        check $BG1 $FG1 $BG2 $FG2
        echo ""
        outputColor
    fi  
else
    echo "Не должно быть аргументов"
    exit 1
fi
}
