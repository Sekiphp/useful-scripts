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
    if [ "$2" = "-b" ] && [ -n "$3" ];
    then
        BRANCH="$3"
    else
        echo "Missing third parameter!"
        show_syntax
    fi;

	git checkout "$BRANCH"
	git pull
	git checkout -b "$1"
else
    echo -e "$COLOR_RED"Please, specify name of new branch."$COLOR_WHITE"
    show_syntax
fi;
