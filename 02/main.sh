#!/bin/bash                                                                                                  

source out.sh
output
echo "Записать данные в файл? [Y/n]"
read answer
if [[ $answer = Y || $answer = y ]]; then
        file=$(date +"%d_%m_%Y_%H_%M_%S".status)
        output>$file
fi