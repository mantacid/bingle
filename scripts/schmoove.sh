#!/usr/bin/env bash
## This file handles the Schmoovement of data between tabs, windows, and other bingle elements. It's currently a bit hacky, but I hope to polish it up incrementally.
## When implementing tab-to-widget dragging, remember that the tabs don't need to be displayed in that case, and that the implementation can be simplified because of this.

## NOTE: make a directory for each window, so that its window definition can be stored and accessed by eww.
#######################################################################################
## GLOBALS
BINGLE_CONF_DIR="$HOME/github/bingle"

#######################################################################################
## get-temp-dir()
## a small function to print the location of the temporary directory in which the working files will be placed.
## Takes no arguments.
## Returns the path to the temporary directory.

get-temp-dir() {
  echo $(echo "$(pwd)" | sed 's/scripts/tmp\//g')
}

#######################################################################################
## tab-add()
## handler function to create tabs with UUIDs and associate them to windows.
## Takes in a window UUID, the yuck associated with the tab, the label to give the tab, and the icon to show on the tab, if the styles permit it.
## Returns the tab's UUID
## WIP!

tab-add() {
  ## define local variables
  baseJSON="{uuid: 'TABUUID', name: 'LABEL', icon: 'ICON', content: 'CONTENT'}"
  tabUUID=$(uuidgen)

  ## define names for arguments
  winUUID="$1"
  appYuck="$2"
  tabLabl="$3"
  tabIcon="$4"

  winDir="$(get_temp_dir)$winUUID"
  winTabs="${winDir}/tabs.json"

  ## generate the tab json. This will be inserted into the window's tab list. tabs appear in an order defined by their index in the list.
  tabJSON=$(echo $(echo $(echo $(echo $baseJSON | sed "s/TABUUID/$tabUUID/g") | sed "s/LABEL/$tabLabl/g") | sed "s/ICON/$tabIcon/g") | sed "s/CONTENT/$appYuck/g")

  ## find the window JSON file, use python implementation to populate the tab array.
  newJSON=$(python json-handler.py $(echo "$winTabs $tabJSON" $(cat $winTabs)))
}

#######################################################################################
## window-open()
## A handler function to open windows & associate UUIDs with them.
## Takes in first tab as arguments, as well as window position and size.
## Returns the window UUID
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
  winDir="$(get-temp-dir)$winUUID"
  ## winBASE points to a file containing a winndow definition template, the content of which gets added to the file def.yuck inside the window directory.
  winBASE="$BINGLE_CONF_DIR/yuck/util/winDef.yuck"

  ## baseJSON: the basic template json to use to store tabs.
  winBaseJson="$BINGLE_CONF_DIR/yuck/util/winTabsBase.json"

  ## format window position and size for use as an argument to `eww open`
  winPos="${winX}x${winY}"
  winSiz="${winW}x${winH}"

  ##initialize the temporary directory
  mkdir $winDir

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
  echo $(sed "s|WINUUID|$winUUID|g" $pointerYuck) >> $(get-temp-dir)schmoove-pointers.yuck

  ## create and initialize the json that stores the window's tabs. this file will get written to when tab changes occur on that window.
  cat $winBaseJson > $winDir/tabs.json

  ## TODO: below

  ## Write the initial tab to the json file.

  ## open the window, which will contain a variable to track its assigned files
  #eww -c $BINGLE_CONF_DIR open $winUUID -p $winPos -s $winSiz

  ## handle the tab json using the tab-add function (WIP)

  ## once the tab is created, update the last-focused-tab variable to focus the new tab. This will trigger the content to render in the parent window.

  ## return the new window UUID
  echo $winUUID
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
window-open "" 100 50 400 300


