#!/usr/bin/env bash

# Gather uname and make it lowercase
PLATFORM=$(uname | tr '[:upper:]' '[:lower:]')

# Detect platform
case $PLATFORM in

  # OS X
  darwin)
    echo 'osx'
  ;;

  # Linux
  linux)
    echo 'linux'

    # Gather release info
    if [[ -n `command -v lsb_release` ]]; then
      # dump release info and drop version
      DISTRO=`lsb_release -ds 2>/dev/null | sed 's:^\(.*\) .*:\L\1:'`
    else
      # grab first entry and remove extraneous path and filename affixes
      DISTRO=`echo /etc/*release | head -1 | sed 's:/etc/\(.*\)-release:\1:'`
    fi

    # Detect distro
    case $DISTRO in
      ubuntu)
        echo 'ubuntu'
        ;;

      gentoo)
        echo 'gentoo'
        ;;

      *)
        echo 'Unknown distro' $DISTRO
        exit 2
        ;;
    esac
    ;;

  *)
    echo 'Unknown platform' $PLATFORM
    exit 1
    ;;
esac
