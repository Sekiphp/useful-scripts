#!/bin/bash
clear

CURRENT=$(git name-rev --name-only HEAD)
CHANGES=$(git status -su | wc -l)

# sync with another branch
BRANCH="master"
if [ "$1" = "-b" ] && [ -n "$2" ];
then
    BRANCH="$2"
fi

# is there something for add to stage?
if [ "$CHANGES" -ne "0" ];
then
	git stash
fi

git checkout "$BRANCH"
git pull
git checkout "$CURRENT"
git merge "$BRANCH" -m "Update $CURRENT from $BRANCH"

if [ "$CHANGES" -ne "0" ];
then
	git stash pop
fi

git status
