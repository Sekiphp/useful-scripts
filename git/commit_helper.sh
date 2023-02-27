#!/bin/bash
clear

COLOR_RED="\033[0;31m"
COLOR_GREEN="\033[0;32m"
COLOR_BLUE="\e[36m"
COLOR_WHITE="\033[0;37m"
#COLOR_YELLOW="\033[0;33m"
#COLOR_OCHRE="\033[38;5;95m"
CHANGED_FILES_WARN=25

show_help() {
    #echo -e '\n'
    echo -e '\t' "+----------------------- HELP -----------------------+"
    echo -e '\t' "| (a)dd - add file to index                          |"
    echo -e '\t' "| (i)gnore - skip file                               |"
    echo -e '\t' "| (r)eset - unstage file                             |"
    echo -e '\t' "| checkout - checkout file (discard changes)         |"
    echo -e '\t' "| rm - remove file                                   |"
    echo -e '\t' "+----------------------------------------------------+"
}

show_hr() {
    echo =====================================================================================================================================================
}

read_command() {
    while read -p "$: " cmd </dev/tty
    do
        if [ "$cmd" != "q" ] && [ "$cmd" != "" ];
        then
            break
        fi
    done
}

CHANGED_FILES=$(git status -su | wc -l)
if [[ "$CHANGED_FILES" -ge "$CHANGED_FILES_WARN" ]];
then
    echo "Too many changed files ($CHANGED_FILES). Are you sure to continue? [y/n]"

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
fi

declare -i PROCESSED_FILES=0
git status -su | tr \\r \\n | while read -r line;
do
    FILE=$(echo "$line" | awk '{$1 = ""; print substr($0,2)}' | sed 's/^"\|"$//g') # sed removing backslashes
    STATUS=$(echo "$line" | awk '{print substr($1,0,2)}')
    FILE_MIME=$(file --mime-type "$FILE" | grep -E "text|json|csv" -c)

    PROCESSED_FILES+=1

    show_hr

    tput smso
    echo "($PROCESSED_FILES / $CHANGED_FILES) Checking file: $FILE (status $STATUS)"
    tput rmso

    if [[ "$FILE_MIME" = 0 ]];
    then
        echo "I'm not able to show content of binary file!"
    elif [ "$STATUS" = "M" ] || [ "$STATUS" = "AM" ] || [ "$STATUS" = "MM" ];
    then
        gdiff=$(git diff --color "$FILE")

        if [[ "$gdiff" = "" ]];
        then
            gdiff=$(git diff --color --cached "$FILE")
        fi

        echo "$gdiff"
    elif [[ "$STATUS" = "D" ]];
    then
        echo -e "$COLOR_RED"
        echo "File $FILE has been deleted"
        echo -e "$COLOR_WHITE"
    elif [[ "$STATUS" = "??" ]];
    then
        # untracked files
        echo -e "$COLOR_BLUE"
        cat "$FILE"
        echo -e "$COLOR_WHITE"
    elif [[ "$STATUS" = "A" ]];
    then
        # new files (which are in stage)
        echo -e "$COLOR_BLUE"
        cat "$FILE"
        echo -e "$COLOR_WHITE"
    fi

    show_help
    read_command

    if [ "$cmd" = "a" ] || [ "$cmd" = "add" ];
    then
        git add "$FILE"
        echo "File was added to index"
    elif [ "$cmd" = "i" ] || [ "$cmd" = "skip" ];
    then
        echo "Skiped to the next file"
    elif [ "$cmd" = "checkout" ];
    then
        git checkout "$FILE"
        echo "File was checkouted to original version"
    elif [ "$cmd" = "r" ] || [ "$cmd" = "reset" ];
    then
        git reset "$FILE"
        echo "File was unstaged"
    elif [[ "$cmd" = "rm" ]];
    then
        rm "$FILE"
    fi

done

show_hr
git status
