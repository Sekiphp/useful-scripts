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
ls -d */ | while read -r folder;
do
    GIT_TOPLEVEL_FOLDER=$(git -C $folder rev-parse --show-toplevel)'/'
    CURRENT_FOLDER=$(pwd)'/'$folder

    if [[ "${GIT_TOPLEVEL_FOLDER}" != "${CURRENT_FOLDER}" ]];
    then
        echo -e "$COLOR_RED"
        echo "Folder ${folder} is not git repository!"

        continue
    fi

    GIT_STATUS=$(git -C $folder status -su)

    if [[ "$1" = "--empty" ]] || [[ ! -z "$GIT_STATUS" ]];
    then
        echo -e "$COLOR_BLUE"
        echo 'Showing git status of folder:' $folder
    fi

    if [[ ! -z "$GIT_STATUS" ]];
    then
        echo -e "$COLOR_WHITE"
        echo "$GIT_STATUS"
    fi

done
