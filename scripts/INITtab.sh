#!/bin/bash
## names for arguments
TabLabel=$1
TabIcon=$2
WINDOW_TARGET=$3 ##Window ID of the window that will house the tab


UUID_NEW=$(uuidgen)

YUCK_TAB_DATA="(tab :UUID '${UUID_NEW}' :tabLabel '${TabLabel}' :tabIcon '${TabIcon}')"

## TODO: get this data to the window somehow UNFINISHED
