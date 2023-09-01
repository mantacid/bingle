#!/usr/bin/env bash
## This file handles the Schmoovement of data between tabs, windows, and other bingle elements. It's currently a bit hacky, but I hope to polish it up incrementally.
## When implementing tab-to-widget dragging, remember that the tabs don't need to be displayed in that case, and that the implementation can be simplified because of this.

## NOTE: make a directory for each window, so that its window definition can be stored and accessed by eww.
#######################################################################################
## GLOBALS
BINGLE_CONF_DIR="$HOME/github/bingle"

#######################################################################################
## bingle_init()
## initializes the temp direcotry where bingle window data will be stored
## takes no arguments
## returns nothing, but sets the global variable
## IF CALLED MULTIPLE TIMES, WILL NOT OVERWRITE CURRENT SESSION'S DATA
bingle-init() {
  ## check if a bingle temp dir already exists, set the value of $tmpDir if it does (as that would indicate a session that has already been initialized). if not, create a new temp dir.
  recovery_check="$(ls -d /tmp/* | grep /bingle_)"
  if [ "$recovery_check" = "" ];
  then
    declare -g tmpDir=$(mktemp -d /tmp/bingle_XXXXXXXX)
  else
    declare -g tmpDir="$recovery_check"
  fi
  #echo $tmpDir
}

#######################################################################################
## tab-add()
## handler function to create tabs with UUIDs and associate them to windows.
## Takes in the name of the window directory, the window UUID (might remove this later), the yuck associated with the tab, the label to give the tab, and the icon to show on the tab, if the styles permit it.
## Returns the tab's UUID
## WIP!

tab-add() {
  ## define local variables
  baseJSONPath="$BINGLE_CONF_DIR/yuck/util/tabTemplate.json"
  tabUUID=$(uuidgen)
  baseJSON=$(cat $baseJSONPath)
  ## define names for arguments
  winDir="$1"
  winUUID="$2"
  tabCont="$3"
  tabLabl="$4"
  tabIcon="$5"

  ##winDir="$(get_temp_dir)$winUUID"
  winTabs="${winDir}/tabs.json"

  ## find the window JSON file, use python implementation to populate the tab array.
  python tab-add.py $winDir "$BINGLE_CONF_DIR/yuck/util/tabTemplate.json" $tabUUID $tabLabl $tabIcon
}

#######################################################################################
## window-open()
## A handler function to open windows & associate UUIDs with them.
## Takes in first tab as arguments, as well as window position and size.
## Returns the window directory
## WIP!

window-open() {
  ## define names for arguments. measurements MUST include their units.
  firstTab="$1"
  winX="$2"
  winY="$3"
  winW="$4"
  winH="$5"

  ## define local variables.
  ## winUUID is an identifying value to name the eww window and its associated files.
  winUUID=$(uuidgen)
  ## winDir points to the directory associated with this window.
  #winDir="$(get-temp-dir)$winUUID"
  ## winBASE points to a file containing a winndow definition template, the content of which gets added to the file def.yuck inside the window directory.
  winBASE="$BINGLE_CONF_DIR/yuck/util/winDef.yuck"

  ## baseJSON: the basic template json to use to store tabs.
  winBaseJson="$BINGLE_CONF_DIR/yuck/util/winTabsBase.json"

  ## format window position and size for use as an argument to `eww open`
  winPos="${winX}x${winY}"
  winSiz="${winW}x${winH}"

  ##initialize the temporary directory for the window
  winDir=$(mktemp -d $tmpDir/XXXXXXXX)

  ## create and populate the window definition
  cat $winBASE > $winDir/def.yuck

  ## format the new window definition to include relevant information
  ## Optimize later
  echo $(sed "s|WINDIR|$winDir|g" $winDir/def.yuck) > $winDir/def.yuck
  echo $(sed "s|WINUUID|$winUUID|g" $winDir/def.yuck) > $winDir/def.yuck
  echo $(sed "s|WINX|$winX|g" $winDir/def.yuck) > $winDir/def.yuck
  echo $(sed "s|WINY|$winY|g" $winDir/def.yuck) > $winDir/def.yuck
  echo $(sed "s|WINW|$winW|g" $winDir/def.yuck) > $winDir/def.yuck
  echo $(sed "s|WINH|$winH|g" $winDir/def.yuck) > $winDir/def.yuck

  ## pull some yuck from a util file to add to the pointer list
  pointerYuck=$BINGLE_CONF_DIR/yuck/util/winPointer.yuck

  ## format the contents of this new file
  echo $(sed "s|WINDIR|$winDir|g" $pointerYuck) >> $BINGLE_CONF_DIR/yuck/util/schmoove-pointers.yuck

  ## create and initialize the json that stores the window's tabs. this file will get written to when tab changes occur on that window.
  cat $winBaseJson > $winDir/tabs.json

  ## TODO: below

  ## Write the initial tab to the json file.

  ## open the window, which will contain a variable to track its assigned files
  #eww -c $BINGLE_CONF_DIR open $winUUID -p $winPos -s $winSiz

  ## handle the tab json using the tab-add function (WIP)

  ## once the tab is created, update the last-focused-tab variable to focus the new tab. This will trigger the content to render in the parent window.

  ## return the new window UUID
  echo $winDir
}

#######################################################################################
## tab-remove()
## removes a tab from a window file
## Takes in a window UUID, a tab UUID.
## Returns nothing.
## WIP!

tab-remove() {
## local names for arguments
winUUID="$1"
tabUUID="$2"

## local variables
winDir="$(get-temp-dir)$winUUID"

## call python implementation to handle the removal of the json list item with the key $tabUUID that is located in the file $winDir/tabs.json
}

#######################################################################################
## window-close()
## a handler function to close windows and remove any temporary resources associated with them
## Takes in the UUID of the window to close
## Returns nothing.
## WIP!

window-close() {
  ## local argument names
  winUUID="$1"

  ## define the window directory
  winDir="$(get-temp-dir)$winUUID"

  ## TODO: check for tabs with unsaved content, send a confirmation dialog before closing the window.

  ## delete the temporary window directory, along with its contents.
  rm -rf $winDir

  ## close the window
  eww -c $BINGLE_CONF_DIR close $winUUID
}



## MAIN CALL, FOR DEBUG PURPOSES ONLY
bingle-init
test_win=$(window-open "testYuck" 100 50 400 300)
tab-add $test_win $(uuidgen) "testYuck" "testing" "process-stop-symbolic"
