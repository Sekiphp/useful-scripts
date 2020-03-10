#!/bin/bash
clear

CURRENT=$(git name-rev --name-only HEAD)

BRANCH="master"
if [ "$1" = "-b" ] && [ -n "$2" ];
then
    BRANCH="$2"
fi

git stash
git checkout "$BRANCH"
git pull
git checkout "$CURRENT"
git merge "$BRANCH" -m "Update $CURRENT from $BRANCH"
git stash pop

git status
