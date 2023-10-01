#!/usr/bin/env bash
####################################################################################
## watch: watches a config at CONF_PATH for changes.
watch_changes() {
  ## local names for arguments
  CONF_PATH="$1"
  ## watch the config file
  TEMP_FILE=$(mktemp)
  (fswatch -bat --event=Updated $CONF_PATH) >> $TEMP_FILE
  ## prevent the file from growing too large?
  ## WIP ##
  ## output the name of the tempfile so that the yuck can create a listener for it
  ## the yuck listener will call this script.
  echo $TEMP_FILE
}
####################################################################################
## MAIN CALL ##
watch_changes '/home/bingle/.config/eww/conf/main.json'
