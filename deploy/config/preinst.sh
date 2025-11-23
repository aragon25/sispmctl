#!/bin/bash
if [ "$(which sispmctl)" != "" ] && [ "$1" == "install" ]; then
  echo "The command \"sispmctl\" is already present. Can not install this."
  echo "File: \"$(which sispmctl)\""
  exit 1
fi
exit 0