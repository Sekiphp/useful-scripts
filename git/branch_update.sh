#!/bin/bash

CURRENT=$(git name-rev --name-only HEAD)

git checkout master
git pull
git checkout "$CURRENT"
git merge master -m "Update $CURRENT from master"

git status