#!/bin/bash

if [[ "$1" ]];
then
    echo "Delete branch"
    git branch -D "$1"
    git push origin -d "$1"
else
    echo -e "${COLOR_RED}Please, specify name of new branch.${COLOR_WHITE}"
    show_syntax
fi
