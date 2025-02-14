#!/bin/bash

if [ -z "$1" ]; then
  echo "Please enter the tag name."
  exit 1
fi

git tag -a "$1" -m "$1"
git push origin "$1"
