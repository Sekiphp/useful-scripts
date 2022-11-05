#!/bin/bash

COLOR_RED="\033[0;31m"
COLOR_GREEN="\033[0;32m"
COLOR_BLUE="\e[36m"
COLOR_WHITE="\033[0;37m"

clear

# show mode
if [[ "$1" = "--empty" ]];
then
    echo "Show all directories..."
else
    echo "Show only repositories with uncommitted changes..."
    echo "You can use --empty flag to show all folder"
fi

# iterate folders
ls -d * | while read -r folder;
do
    GIT_STATUS=$(git -C $folder status -su)

    if [[ "$1" = "--empty" ]] && [[ -z "$GIT_STATUS" ]];
    then
        echo -e "$COLOR_BLUE"
        echo 'Showing git status of folder:' $folder
    fi

    if [[ ! -z "$GIT_STATUS" ]];
    then
        if [[ ! "$1" = "--empty" ]];
        then
            echo -e "$COLOR_BLUE"
            echo 'Showing git status of folder:' $folder
        fi

        echo -e "$COLOR_WHITE"
        echo "$GIT_STATUS"
    fi

done;

