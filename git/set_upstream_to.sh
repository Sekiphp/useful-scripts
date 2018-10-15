#!/bin/bash

COLOR_RED="\033[0;31m"
COLOR_WHITE="\033[0;37m"


CURRENT=$(git name-rev --name-only HEAD)
git branch --set-upstream-to=origin/"$CURRENT" "$CURRENT"

echo -e "$COLOR_RED git branch --set-upstream-to=origin/$CURRENT $CURRENT $COLOR_WHITE"
