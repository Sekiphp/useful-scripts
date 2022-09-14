#!/bin/bash

COLOR_RED="\033[0;31m"
COLOR_GREEN="\033[0;32m"
COLOR_BLUE="\e[36m"
COLOR_WHITE="\033[0;37m"

clear

read_command() {
    while read -p "$: " cmd </dev/tty
    do
        if [ "$cmd" != "q" ] && [ "$cmd" != "" ];
        then
            break
        fi
    done
}

echo 'This script loops all folders in current directory "'$(pwd)'" and show git changes.'
echo 'Do you want to continue?'
while :; do
    read_command

    if [ "$cmd" == "y" ];
    then
        break
    fi

    if [ "$cmd" == "n" ];
    then
         exit 100
     fi
done


ls -d */ | while read -r line;
do
    echo -e "$COLOR_BLUE"
    echo 'Showing git status of folder:' $line
    echo -e "$COLOR_WHITE"

    exec 3>&1
    exec 1> >(paste /dev/null -)

    git -C $line status

    exec 1>&3 3>&-
done;
