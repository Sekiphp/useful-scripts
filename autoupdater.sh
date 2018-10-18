#!/bin/bash
clear

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
REMOTE_HASH="$( curl -s https://api.github.com/repos/Sekiphp/useful-scripts/commits/master | grep -m1 -o -P '(?<="sha": ")[^"]+' )"
LOCAL_HASH="$( git -C $DIR rev-parse HEAD)"

if [ "$REMOTE_HASH" == "$LOCAL_HASH" ];
then
    echo "Useful-scripts is up to date!"
else

    while read -p "Do you want to update useful-scripts? (Y/N): " cmd </dev/tty
    do
        cmd=${cmd^^}
        if [ "$cmd" = "Y" ] || [ "$cmd" = "N" ];
        then
            break;
        fi
    done

    if [[ "$cmd" = "Y" ]];
    then
        git -C "$DIR" fetch
        echo "Updated successfully";
    fi
fi