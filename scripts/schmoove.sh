#!/bin/bash
## handles the schmovement of data
## NOTE: make a directory for each window, so that its window definition can be stored and accessed by eww.

##define variables global to this scripts
WIN_BASE="(defwindow WINDOW :geometry (geometry :anchor 'top left') :wm-ingore false :stacking 'bg' :windowtype 'normal' (winBingle :content-yuck '(context)' :winUUID 'WINDOW'))"

get-temp-dir() {
  echo $(echo "$(pwd)" | sed 's/scripts/tmp\//g')
}
## handler function to open a window
window-open() {
  ## define local variables
  winUUID=$(uuidgen)

  ## define names for arguments
  #firstTab="$1"
  winX="$2"
  winY="$3"
  winW="$4"
  winH="$5"

  ## format window position for use as an argument to `eww open`

  ## replace all instances of placeholder text 'WINDOW' with the window's UUID, so that it can be referred to and passed to children widgets
  winYuck=$(echo $WIN_BASE | sed "s/WINDOW/${winUUID}/g")

  ##initialize the temporary directory
  winDir="$(get_temp_dir)/$winUUID"
  mkdir $winDir

  ## create the window definition file
  cat $winYuck > $winDir/def.yuck

  ## prepend some yuck to the pointer file to help us reference the window later
  pointerYuck="(include 'tmp/$winUUID/def.yuck')"
  sed -i 'ls/^/${pointerYuck}\n/' $(get-temp-dir)/schmoove-pointers.yuck

  ## handle the tab json using the tab-add function (WIP)
}

window-close() {
##WIP
}

tab-add() {
##WIP
}

tab-remove() {
##WIP
}
