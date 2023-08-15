#!/bin/bash
## define static values, let flags override them
ewwConfDir="${XDG_CONFIG_HOME}/eww/"
NEW_WALLPAPER=${@: -1}
declare wpFitmode

## flag handling

while getopts 'c:' flag; do
  case "$flag" in
    c)
      ewwConfDir="$OPTARG"
      ;;
    ?)
      echo "invalid flag(s) ($flag) for wallset."
      echo "USAGE:"
      echo "wallset [-c STRING] IMAGE_PATH"
      echo "-c:       use a different config directory than the default eww config. Include a trailing /"
      exit
      ;;
  esac
done

cp $NEW_WALLPAPER $ewwConfDir/wallpaper



