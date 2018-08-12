#!/bin/bash
clear

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
changed=0

git -C "$DIR" remote update && git -C "$DIR" status -uno | grep -q 'Your branch is behind' && changed=1
if [ $changed = 0 ];
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
        git -C "$DIR" pull
        echo "Updated successfully";
    fi
fi