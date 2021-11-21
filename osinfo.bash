#!/usr/bin/env bash

# Gather uname and make it lowercase
PLATFORM=$(uname | tr '[:upper:]' '[:lower:]')
echo $PLATFORM

# Detect distro
DISTRO='unknown'
case $PLATFORM in

  # OS X
  darwin)
    DISTRO='osx'
  ;;

  # Linux
  linux)
    # Gather release info
    if [[ -n `command -v lsb_release` ]]; then
      # Some distros have an lsb_release command that we can use
      # dump release info and drop version
      DISTRO=`lsb_release -ds 2>/dev/null | sed 's:^\(.*?\) .*:\L\1:'`
    elif [[ -n `echo /etc/*release` ]]; then
      # Ohers have a file in /etc with the name of the distro in the filename
      # grab first entry and remove extraneous path and filename affixes
      DISTRO=`echo /etc/*release | head -1 | cut -d " " -f 1 | sed 's:/etc/\(.*\)-release:\1:'`
    fi
  ;;

esac

DISTRO="$(echo "$DISTRO" | tr '[:upper:]' '[:lower:]')"

echo $DISTRO
