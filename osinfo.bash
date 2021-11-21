#!/usr/bin/env bash

# used in conditionals to determine presence of a command or executable
command_exists() { command -v "$1" > /dev/null 2>&1; }
version_gte() { [[ $1 = $( echo -e "$1\n$2" | sort -V | tail -1) ]]; }

# Gather uname and make it lowercase
PLATFORM="$(uname | tr '[:upper:]' '[:lower:]')"
echo "$PLATFORM"

# Detect distro
DISTRO="unknown"
case $PLATFORM in

  # macOS
  darwin)
    if command_exists sw_vers; then
      VERSION="$(sw_vers | grep ProductVersion | cut -d ':' -f2)"

      OSX="10.8"
      MACOS="10.12"

      if version_gte "$VERSION" "$MACOS"; then
        # current branding since 2016
        DISTRO="macos"
      elif version_gte "$VERSION" "$OSX"; then
        # old branding between 2012-2016
        DISTRO="osx"
      else
        # original branding between 2001-2012
        DISTRO="macosx"
      fi
    fi
  ;;

  # Linux
  linux)
    # Gather release info
    if command_exists lsb_release; then
      # Some distros have an lsb_release command that we can use
      # dump release info and drop version
      DISTRO="$(lsb_release -ds 2>/dev/null | sed 's:^\([[:graph:]]*\) .*:\L\1:')"
    elif [[ -n $(echo /etc/*release) ]]; then
      # Ohers have a file in /etc with the name of the distro in the filename
      # grab first entry and remove extraneous path and filename affixes
      DISTRO="$(echo /etc/*release | head -1 | cut -d " " -f 1 | sed 's:/etc/\(.*\)-release:\1:')"
    fi
  ;;

esac

DISTRO="$(echo "$DISTRO" | tr '[:upper:]' '[:lower:]')"
DISTRO="${DISTRO%\"}"
DISTRO="${DISTRO#\"}"

echo "$DISTRO"
