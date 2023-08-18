#!/bin/bash
## This file handles the Schmoovement of data between tabs, windows, and other bingle elements. It's currently a bit hacky, but I hope to polish it up incrementally.

## NOTE: make a directory for each window, so that its window definition can be stored and accessed by eww.

#######################################################################################
## get-temp-dir
## a small function to print the location of the temporary directory in which the working files will be placed.
## Takes no arguments.
## Returns the path to the temporary directory.

get-temp-dir() {
  echo $(echo "$(pwd)" | sed 's/scripts/tmp\//g')
}

#######################################################################################
## tab-add: handler function to create tabs with UUIDs and associate them to windows.
## Takes in a window UUID, the yuck associated with the tab, the label to give the tab, and the icon to show on the tab, if the styles permit it.
## Returns the tab's UUID
## WIP!

tab-add() {
  ## define local variables
  baseJSON="TABUUID: {name: 'LABEL', icon: 'ICON', content: 'CONTENT'},"
  tabUUID=$(uuidgen)

  ## define names for arguments
  winUUID="$1"
  appYuck="$2"
  tabLabl="$3"
  tabIcon="$4"


}

#######################################################################################
## window-open: A handler function to open windows & associate UUIDs with them.
## Takes in first tab as arguments, as well as window position and size.
## Returns the window UUID
## WIP!

window-open() {
  ## define local variables
  winBASE="(defwindow WINDOW :geometry (geometry :anchor 'top left') :wm-ingore false :stacking 'bg' :windowtype 'normal' (winBingle :content-yuck '(context)' :winUUID 'WINDOW'))"
  winUUID=$(uuidgen)

  ## define names for arguments
  #firstTab="$1"
  winX="$2"
  winY="$3"
  winW="$4"
  winH="$5"

  ## format window position and size for use as an argument to `eww open`
  winPos="${winX}x${winY}"
  winSiz="${winW}x${winH}"

  ## replace all instances of placeholder text 'WINDOW' with the window's UUID, so that it can be referred to and passed to children widgets
  winYuck=$(echo $winBASE | sed "s/WINDOW/${winUUID}/g")

  ##initialize the temporary directory
  winDir="$(get_temp_dir)/$winUUID"
  mkdir $winDir

  ## create the window definition file
  cat $winYuck > $winDir/def.yuck

  ## prepend some yuck to the pointer file to help us reference the window later
  pointerYuck="(include 'tmp/$winUUID/def.yuck')"
  sed -i 'ls/^/${pointerYuck}\n/' $(get-temp-dir)/schmoove-pointers.yuck

  ## open the window, which will contain a variable to track its assigned files

  ## handle the tab json using the tab-add function (WIP)

  ## once the tab is created, update the last-focused-tab variable to focus the new tab. This will trigger the content to render in the parent window.

  ## return the new window UUID
  echo $winUUID
}

#######################################################################################
## tab-remove: removes a tab from a window file
## Takes in a window UUID, a tab UUID.
## Returns nothing.
## WIP!

tab-remove() {

}

#######################################################################################
## window-close: a handler function to close windows and remove any temporary resources associated with them
## Takes in the UUID of the window to close
## Returns nothing.
## WIP!

window-close() {

}


