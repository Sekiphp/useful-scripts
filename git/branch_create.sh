#!/bin/bash
clear

COLOR_RED="\033[0;31m"
COLOR_WHITE="\033[0;37m"

show_syntax() {
    echo "Syntax: gbc NEW_BRANCH_NAME [-b FROM_BRANCH]"
}

if [[ "$1" ]];
then
    BRANCH="master"
    if [[ "$2" = "-b" ]];
    then
        if [[ "$#" -ne 4 ]];
        then
            echo -e "$COLOR_RED"Missing third parameter, I use master branch!"$COLOR_WHITE"
            show_syntax
        else
            BRANCH="$3"
        fi
    fi

    if [[ $(git branch | grep "$1" | wc -l) = "0" ]];
    then
        git checkout "$BRANCH"
        git pull
        git checkout -b "$1"
    else
        echo -e "$COLOR_RED"Moving to existing git branch."$COLOR_WHITE"
        git checkout "$1"
    fi
else
    echo -e "$COLOR_RED"Please, specify name of new branch."$COLOR_WHITE"
    show_syntax
fi
