#!/bin/bash

if [ $# -eq 0 ]; then
  echo -e "\nFix filenames recursively.\n\nSyntax: $(basename $0) <folder>\n"
  exit 1
else
  if [ -n "$1" ]; then
    if [ -d "$1" ]; then
      echo "Processing: $1"
    else
      echo "Invalid folder: $1"
      exit 1
    fi
  fi
fi

which detox >/dev/null 2>&1
if [ $? -eq 1 ]; then
  echo "Installing detox package..."
  sudo apt-get install -yqq detox
fi

which detox >/dev/null 2>&1
if [ $? -eq 1 ]; then
  echo "ERROR: Detox is not installed!"
  exit 1
fi

detox --special -r -v -s utf_8 "$1/"
detox --special -r -v -s lower "$1/"

find "$1/" -type d -exec chmod 0755 {} \;
find "$1/" -type f -exec chmod 0644 {} \;

echo -e "\nDone.\n"
