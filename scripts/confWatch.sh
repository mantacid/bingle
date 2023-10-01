#!/usr/bin/env bash
# ####################################################################################
# ## watch_changes: watches a config at CONF_PATH for changes.
# watch_changes() {
#   ## local names for arguments
#   CONF_PATH="$1"
#   declare -g TEMP_FILE="/tmp/confWatch" ## uncomment this to be able to easily find and debug the changelog
#   #declare -g TEMP_FILE=$(mktemp)
#   ## output the name of the temp file
#   echo $TEMP_FILE
#   ## set up the watcher, fork into background & a[ppend output into tempfile]
#   fswatch -bat --event=Updated $CONF_PATH &>> $TEMP_FILE
# }
# ####################################################################################
# ## listen_content: outputs the full config whenever it is updated.
# ## will format the json to not use spaces outside of strings.
# ## takes in the path of the config file
# listen_content() {
#   ## local names for arguments
#   CONF_PATH="$1"
#   ## fork the watch_changes function to the background, providing the name of the temp file as a global variable
#   watch_changes $CONF_PATH &
#   ## now that it is running in the background,
# }
####################################################################################
## __RUN_CMD__: contains the call to the command needed to format the file
## ARGS: path to config, length of the config file
__RUN_CMD__() {
  ## output the changes when they occur.
  DATA=$(python bicon.py $1)
  echo $DATA >> /tmp/confWatch
  trap "rm -f /tmp/confWatch;exit" 0 2
}
####################################################################################
## trigger_update: function that can be used in an eww listener to automatically read AND format a config file when it is updated
trigger_update() {
  ## local names for arguments
  CONF_PATH="$1"
  ## get the file length
  F_LEN=$(wc -c < "$CONF_PATH")
  ## tail the file
  #tail --bytes=$F_LEN -f $CONF_PATH &
  #tailpid=$!
  #trap "kill $tailpid; exit" 0 2
  ## use the file modification time to trigger events
  lastmtime=0
  while read -r mtime < <(stat -c '%Z' "$CONF_PATH")
  do
    if [[ $lastmtime != $mtime ]]
    then
      lastmtime=$mtime
      __RUN_CMD__ "$CONF_PATH" "$F_LEN"
    fi
    sleep 1
  done
}

####################################################################################
## MAIN CALL ##
trigger_update '/home/bingle/github/bingle/conf/main.json'

