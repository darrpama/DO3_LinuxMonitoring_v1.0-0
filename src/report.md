# Linux Monitoring v1.0

### Part 1. Проба пера

**== Задание и выполнение ==**

Написать bash-скрипт. Скрипт запускается с одним параметром. Параметр текстовый.
Скрипт выводит значение параметра.  
Если параметр - число, то должно выводится сообщение о некорректности ввода.

```
#!/bin/bash
if [ $# -eq 1 ] 
then
        check=$(echo "$1" | grep -E "^\-?[0-9]*\.?[0-9]+$")
        if [ "$check" != '' ]
        then
                echo "aboba"
        else
                echo "not aboba"
        fi
else
        echo "There is not 1 param"
fi
```
![first bash script text and use](/src/screenshots/aboba.png)