#!/bin/bash
clear

COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"

show_help() {
    echo -e '\n\t' "+----------------------- HELP -----------------------+"
    echo -e '\t' "| (a)dd - add file to index                          |"
    echo -e '\t' "| (i)gnore - skip file                               |"
    echo -e '\t' "| checkout - checkout file (discard changes)         |"
    echo -e '\t' "+----------------------------------------------------+"
}

read_command() {
    while read -p "$: " cmd </dev/tty
    do
        if [ "$cmd" != "q" ] && [ "$cmd" != "" ];
        then
            break;
        fi
    done
}

git status -su | tr \\r \\n | while read -r line ;
do
    FILE=$(echo "$line" | awk '{$1 = ""; print substr($0,2)}')
    STATUS=$(echo "$line" | awk '{print substr($1,0,2)}')

    echo =====================================================================================================================================================

    #tput smso
    echo "Checking file: $FILE (status $STATUS)"
    #tput rmso

    if [[ "$STATUS" = "M" ]];
    then
        git diff "$FILE"

        #if [[ $(git diff "$FILE") = "" ]];
        #then
        #    echo "caaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        #    diff=$(git diff --cached "$FILE")
        #fi

    elif [[ "$STATUS" = "D" ]];
    then
        #echo -e $COLOR_RED
        echo "File $FILE has been deleted"
        #echo -e $COLOR_WHITE
    elif [[ "$STATUS" = "??" ]];
    then
        cat "$FILE"
    fi

    show_help
    read_command

    if [ "$cmd" = "a" ] || [ "$cmd" = "add" ];
    then
        git add $FILE
        echo "File was added to index"
    elif [ "$cmd" = "i" ] || [ "$cmd" = "skip" ];
    then
        echo "Skiped to the next file"
    elif [ "$cmd" = "checkout" ];
    then
        git checkout $FILE
        echo "File was checkouted to original version"
    fi

done

