#!/bin/bash

clear

if [[ "$1" ]];
then
	git checkout master
	git pull
	git checkout -b "$1"
fi;
