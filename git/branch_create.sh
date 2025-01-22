#!/bin/bash
clear

COLOR_RED="\033[0;31m"
COLOR_WHITE="\033[0;37m"

show_syntax() {
    echo -e "Usage: gbc NEW_BRANCH_NAME [-b FROM_BRANCH]"
	echo -e "Create new git branch or checkout to existing branch.\n"

	echo -e " -b\tName of existing branch;\n\tIf argument -b is not present, default branch is used (for this repository is $(default_branch)).\n"
	echo -e " --help\tShow help"
}

default_branch() {
	echo $(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
}

if [[ "$1" ]];
then
    BRANCH=$(default_branch)
    if [[ "$2" = "-b" ]];
    then
        if [[ "$#" -ne 3 ]];
        then
            echo -e "${COLOR_RED}Third parameter missing, used branch '$BRANCH'!${COLOR_WHITE}"
        else
            BRANCH="$3"
        fi
    fi

    if [[ $(git branch --list "$1" | wc -l) = "0" ]];
    then
        echo -e "${COLOR_RED}Creating a new git branch.${COLOR_WHITE}"
        git checkout "$BRANCH"
        git pull
        git checkout -b "$1"
    else
        echo -e "${COLOR_RED}Moving to existing git branch.${COLOR_WHITE}"
        git checkout "$1"
    fi
else
    echo -e "${COLOR_RED}Please, specify name of new branch.${COLOR_WHITE}"
    show_syntax
fi
