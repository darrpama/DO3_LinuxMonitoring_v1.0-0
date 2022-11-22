# Linux Monitoring v1.0

### Part 1. Проба пера

**== Задание и выполнение ==**

Написать bash-скрипт. Скрипт запускается с одним параметром. Параметр текстовый.
Скрипт выводит значение параметра.  
Если параметр - число, то должно выводится сообщение о некорректности ввода.

### main.sh:
```
#!/bin/bash

source err.sh

if [ $# -eq 1 ] 
then
    check=$(echo "$1" | grep -E "^\-?[0-9]*\.?[0-9]+$")
    if [ "$check" != '' ]
    then
        err "aboba"
    else
        echo "OK"
    fi  
else
    err "There is not 1 param"
fi
```
### err.sh:
```
#!/bin/bash
#
# There is function to print errors into the STDERR (&2)
#
# if ! do_something; then
#   err "Unable to do_something"
#   exit 1
# fi

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}
```
### Вывод скрипта:
![first bash script text and use](/src/screenshots/01.png)

### Part 2. Исследование системы

**== Задание и выполнение ==**

Написать bash-скрипт. Скрипт должен вывести на экран информацию в виде:

**HOSTNAME** = _сетевое имя_  
**TIMEZONE** = _временная зона в виде: **America/New_York UTC -5** (временная зона, должна браться из системы и быть корректной для текущего местоположения)_  
**USER** = _текущий пользователь который запустил скрипт_  
**OS** = _тип и версия операционной системы_  
**DATE** = _текущее время в виде: **12 May 2020 12:24:36**_  
**UPTIME** = _время работы системы_  
**UPTIME_SEC** = _время работы системы в секундах_  
**IP** = _ip-адрес машины в любом из сетевых интерфейсов_  
**MASK** = _сетевая маска любого из сетевых интерфейсов в виде: **xxx.xxx.xxx.xxx**_  
**GATEWAY** = _ip шлюза по умолчанию_  
**RAM_TOTAL** = _размер оперативной памяти в Гб c точностью три знака после запятой в виде: **3.125 GB**_  
**RAM_USED** = _размер используемой памяти в Гб c точностью три знака после запятой_  
**RAM_FREE** = _размер свободной памяти в Гб c точностью три знака после запятой_  
**SPACE_ROOT** = _размер рутового раздела в Mб с точностью два знака после запятой в виде: **254.25 MB**_  
**SPACE_ROOT_USED** = _размер занятого пространства рутового раздела в Mб с точностью два знака после запятой_  
**SPACE_ROOT_FREE** = _размер свободного пространства рутового раздела в Mб с точностью два знака после запятой_

После вывода значений предложить записать данные в файл (предложить пользователю ответить **Y/N**).  
Ответы **Y** и **y** считаются положительными, все прочие - отрицательными.
При согласии пользователя, в текущей директории создать файл содержащий информацию, которая была выведена на экран.  
Название файла должно иметь вид: **DD_MM_YY_HH_MM_SS.status** (Время в имени файла должно указывать момент сохранения данных).

### main.sh:
```
#!/bin/bash

source out.sh
output
echo "Записать данные в файл? [Y/n]"
read answer
if [[ $answer = Y || $answer = y ]]; then
        file=$(date +"%d_%m_%Y_%H_%M_%S".status)
        output>$file
fi

```

### out.sh:
```
#!/bin/bash

function output() {
  hostname=$HOSTNAME
  timezone=$(timedatectl | awk ' /Time zone/{print $3" "$4" "$5}')
  user=$(whoami)
  OS=$(uname -s)
  ip=($(ifconfig | awk ' /inet /{print $2} ' | xargs))
  mask=($(ifconfig | awk ' /inet /{print $4}' | xargs))
  gateway=$(ip r | grep 'default via' | awk '{print $3}' | xargs)
  ramTotal=$(free -m | grep Mem | awk '{printf "%.3f\n", $2 / 1024}')
  ramUsed=$(free -m | grep Mem | awk '{printf "%.3f\n", $3 / 1024}')
  ramFree=$(free -m | grep Mem | awk '{printf "%.3f\n", $4 / 1024}')
  spaceRoot=$(df -hk | grep "\/$" | awk '{printf "%.2f\n", $2 / 1024}')
  spaceRootUsed=$(df -hk | grep "\/$" | awk '{printf "%.2f\n", $3 / 1024}')
  spaceRootFree=$(df -hk | grep "\/$" | awk '{printf "%.2f\n", $4 / 1024}')
  echo "hostname          = $hostname"
  echo "timezone          = $timezone"
  echo "user              = $user"
  echo "OS                = $OS"
  ### 
  echo -n "ip                = "
  for (( i = 0; i < ${#ip[*]} ; i++ )); do
    echo -n "${ip[i]} "
  done
  echo -e""
  
  echo -n "mask              = "
  for (( i = 0; i < ${#mask[*]} ; i++ )); do
    echo -n "${mask[i]} "
  done
  echo -e""
  ### 
  echo "gateway           = $gateway"
  echo "Ram total         = $ramTotal Gb"
  echo "Ram used          = $ramUsed Gb"
  echo "Ram free          = $ramFree Gb"
  echo "Space root        = $spaceRoot Mb"
  echo "Space root used   = $spaceRootUsed Mb"
  echo "Space root free   = $spaceRootFree Mb"
}
```
### Вывод скрипта:
![secound bash script output](/src/screenshots/02.png)

### Part 3. Визуальное оформление вывода для скрипта исследования системы

**== Задание и выполнение ==**

Написать bash-скрипт. За основу взять скрипт из [**Part 2**](#part-2-исследование-системы) и убрать из него часть, ответственную за сохранение данных в файл.  
Скрипт запускается с 4 параметрами. Параметры числовые. От 1 до 6, например:  
`script03.sh 1 3 4 5`

Обозначения цветов: (1 - white, 2 - red, 3 - green, 4 - blue, 5 – purple, 6 - black)  
**Параметр 1** - это фон названий значений (HOSTNAME, TIMEZONE, USER и т.д.)  
**Параметр 2** - это цвет шрифта названий значений (HOSTNAME, TIMEZONE, USER и т.д.)  
**Параметр 3** - это фон значений (после знака '=')  
**Параметр 4** - это цвет шрифта значений (после знака '=')

Цвета шрифта и фона одного столбца не должны совпадать.  
При вводе совпадающих значений должно выводится сообщение, описывающее проблему, и предложение повторно вызвать скрипт.  
После вывода сообщения, программа должна корректно завершится.

### main.sh:
```
#!/bin/bash
                                                                               
source out.sh
source check.sh
source color.sh
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

check "$@"
```

### check.sh:
```
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
```
### color.sh:
```
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
```
### out.sh:
```
#!/bin/bash

function output() {
  hostname=$HOSTNAME
  timezone=$(timedatectl | awk ' /Time zone/{print $3" "$4" "$5}')
  user=$(whoami)
  OS=$(uname -s)
  ip=($(ifconfig | awk ' /inet /{print $2} ' | xargs))
  mask=($(ifconfig | awk ' /inet /{print $4}' | xargs))
  gateway=$(ip r | grep 'default via' | awk '{print $3}' | xargs)
  ramTotal=$(free -m | grep Mem | awk '{printf "%.3f\n", $2 / 1024}')
  ramUsed=$(free -m | grep Mem | awk '{printf "%.3f\n", $3 / 1024}')
  ramFree=$(free -m | grep Mem | awk '{printf "%.3f\n", $4 / 1024}')
  spaceRoot=$(df -hk | grep "\/$" | awk '{printf "%.2f\n", $2 / 1024}')
  spaceRootUsed=$(df -hk | grep "\/$" | awk '{printf "%.2f\n", $3 / 1024}')
  spaceRootFree=$(df -hk | grep "\/$" | awk '{printf "%.2f\n", $4 / 1024}')
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
```
### Вывод скрипта:
![third bash script output](/src/screenshots/03.png)

### Part 4. Конфигурирование визуального оформления вывода для скрипта исследования системы

Вот теперь всё красиво! Но как же не хочется каждый раз вбивать цвета как параметры... Надо придумать что-нибудь более удобное.

**== Задание ==**

Написать bash-скрипт. За основу берется скрипт из [**Part 3**](#part-3-визуальное-оформление-вывода-для-скрипта-исследования-системы). Обозначения цветов аналогичные.  
Скрипт запускается без параметров. Параметры задаются в конфигурационном файле до запуска скрипта.  
Конфигурационный файл должен иметь вид:
```
column1_background=2
column1_font_color=4
column2_background=5
column2_font_color=1
```

Если один или несколько параметров не заданы в конфигурационном файле, то цвет должен подставляться из цветовой схемы, заданной по умолчанию. (Выбор на усмотрение разработчика).

После вывода информации о системе из [**Part 3**](#part-3-визуальное-оформление-вывода-для-скрипта-исследования-системы), нужно, сделав отступ в одну пустую строку, вывести цветовую схему в следующем виде:
```
Column 1 background = 2 (red)
Column 1 font color = 4 (blue)
Column 2 background = 5 (purple)
Column 2 font color = 1 (white)
```

При запуске скрипта с цветовой схемой по умолчанию вывод должен иметь вид:
```
Column 1 background = default (black)
Column 1 font color = default (white)
Column 2 background = default (red)
Column 2 font color = default (blue)
```

### main.sh:
```
#!/bin/bash

source outColor.sh
source out.sh
source check.sh

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
```

### check.sh:
```
#!/bin/bash

source config.txt
source ./../01/err.sh
source ./../03/check.sh
source ./../03/color.sh
source ./../03/out.sh
source outColor.sh

function check-1() {
  if [[ $# = 0 ]]; then
    BG1=$column1_background
    BG2=$column2_background
    FG1=$column1_font_color
    FG2=$column2_font_color

    if [[ -z $BG1 ]] || [[ -z $BG2 ]] || [[ -z $FG1 ]] || [[ -z $FG2 ]]; then
      BG1=2; BG2=3; FG1=3; FG2=4;

      colorCheck $BG1 $FG1 $BG2 $FG2
      echo ""
      outputColor default
    else
      check "$BG1" "$FG1" "$BG2" "$FG2"
      echo ""
      outputColor
  fi
  else
    err "Не должно быть аргументов"
    exit 1
  fi
}
```

### outColor.sh:
```
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
```

### out.sh:
```
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
```

### config.txt:
```
column1_background=2
column1_font_color=4
column2_background=5
column2_font_color=1
```
### Вывод скрипта:
![fourth bash script output](/src/screenshots/04.png)

## Part 5. Исследование файловой системы

**== Задание и выполнение ==**

Написать bash-скрипт. Скрипт запускается с одним параметром.  
Параметр - это абсолютный или относительный путь до какой-либо директории. Параметр должен заканчиваться знаком '/', например:  
`script05.sh /var/log/`

Скрипт должен выводить следующую информацию о каталоге, указанном в параметре:
- Общее число папок, включая вложенные
- Топ 5 папок с самым большим весом в порядке убывания (путь и размер)
- Общее число файлов
- Число конфигурационных файлов (с расширением .conf), текстовых файлов, исполняемых файлов, логов (файлов с расширением .log), архивов, символических ссылок
- Топ 10 файлов с самым большим весом в порядке убывания (путь, размер и тип)
- Топ 10 исполняемых файлов с самым большим весом в порядке убывания (путь, размер и хеш)
- Время выполнения скрипта

Скрипт должен вывести на экран информацию в виде:

```
Total number of folders (including all nested ones) = 6  
TOP 5 folders of maximum size arranged in descending order (path and size):  
1 - /var/log/one/, 100 GB  
2 - /var/log/two/, 100 MB  
etc up to 5
Total number of files = 30
Number of:  
Configuration files (with the .conf extension) = 1 
Text files = 10  
Executable files = 5
Log files (with the extension .log) = 2  
Archive files = 3  
Symbolic links = 4  
TOP 10 files of maximum size arranged in descending order (path, size and type):  
1 - /var/log/one/one.exe, 10 GB, exe  
2 - /var/log/two/two.log, 10 MB, log  
etc up to 10  
TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)  
1 - /var/log/one/one.exe, 10 GB, 3abb17b66815bc7946cefe727737d295  
2 - /var/log/two/two.exe, 9 MB, 53c8fdfcbb60cf8e1a1ee90601cc8fe2  
etc up to 10  
Script execution time (in seconds) = 1.5
```

### main.sh
```
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
```

### output.sh
```
#!/bin/bash

function output() {
  startTime=`date +%s%N`
  dirNum=`find "$1" -type d | wc -l`
  echo "Total number of folders (including all nested ones) = $((dirNum-1))"
  echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
  topDir "$1"
  echo "etc up to 5"
  echo "Total number of files = "`find "$1" -type f | wc -l`""

  echo "Number of:"
  echo "Configuration files (with the .conf extension) = "`find "$1" -name "*.conf" | wc -l`""
  echo "Text files = "`find "$1" -name "*.txt" | wc -l`""
  echo "Executable files = "`find "$1" -type f -executable | wc -l`""
  echo "Log files (with the extension .log) = "`find "$1" -name "*.log" | wc -l`""
  echo "Archive files = "`find "$1" -name "*.tar"| wc -l`""
  echo "Symolic links = "`find "$1" -type l | wc -l`""
  echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
  topFile "$1"
  echo "etc up to 10"
  echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
  topExe "$1"
  echo "etc up to 10"
  endTime=$(date +%s%N)
  diffms=$((($endTime - $startTime)/1000000))
  diffs=$(($diffms/1000))
  echo "Script execution time (in seconds) = $diffs.$diffms"            
}
```

### topDir.sh
```
#!/bin/bash

function topDir() {
  out=$(du -h "$1" \
     | sort -rh \
     | head -5 \
     | awk '{print " - "$2", "$1 }')
  IFS=$'\n'
  count=0
  for item in $out
  do
      (( count += 1 ))
  echo "$count $item"
  done
}
```

### topExe.sh
```
#!/bin/bash

function topExe() {
  out="$(find "$1" -type f -executable -not -path '*/\.*' -exec du -h {} + 2>/dev/null \
    | sort -hr \
    | head -n 10 )"
  IFS=$'\n'
  count=0
  for var in $out
  do
      (( count += 1 ))
      path=$(echo "$var" | awk '{print $2}')
      size=$(echo "$var" \
        | awk '{print $1}' \
        | sed -e 's:K: Kb:g' \
        | sed 's:M: Mb:g' \
        | sed 's:G: Gb:g' )
      md5=$(md5sum "$path" | awk '{print $1}')
      printf "%d - %s, %s, %s\n" $count "$path" "$size" "$md5"
  done
}
```

### topFile.sh
```
#!/bin/bash

function topFile() {
  out="$(find "$1" -type f -not -path '*/\.*' -exec du -h {} + 2>/dev/null \
    | sort -hr \
    | head -n 10 )"
  IFS=$'\n'
  count=0
  for var in $out
  do
      (( count += 1 ))
      file=$(echo "$var" | awk '{print $2}')
      size=$(echo "$var" \
        | awk '{print $1}' \
        | sed -e 's:K: Kb:g' \
        | sed 's:M: Mb:g' \
        | sed 's:G: Gb:g' )
      type=$(echo "$var" | awk '{ tp=split($2,type,".") ; print type[tp] }' )
      printf "%d - %s, %s, %s\n" $count "$file" "$size" "$type"
  done
}
```
### Вывод скрипта:
![fifth bash script output](/src/screenshots/05.png)
