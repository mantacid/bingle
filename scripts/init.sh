#!/usr/bin/env bash

## Load the wallpaper and dock
## NOTE: this assumes that you have symlinked the following:
### eww executable ====> /usr/local/bin/eww
### bingle repo =======> ~/.config/eww/

## If you have to keep the default eww configs for whatever reason, edit the command to include the -c flag with the desired config directory, and pass the config path in as the third argument to the bicon.load_to_yuck() function.

## START EWW DAEMON
eww daemon

## init the configs with the values they need (WIP)

## hard-coded to only load the main config, at least for now.
## this only seems to be loading the very last key in the dictionary into the yuck var


## OPEN RELEVANT WIDGETS ONCE CONFIGS ARE LOADED, TO PREVENT FLICKERING/BREAKAGE
#WIDGET_LIST=(
#            'DESKTOP'
#            'DOCK'
#            )
#for i in "${WIDGET_LIST[@]}"; do
#  eww open $i
#  #eww -c path/to/the/bingle/repo open $i
#done
eww open DESKTOP
eww open DOCK
eww open tester
bash confWatch.sh &
eww reload ## RELOAD IN DIFFERENT PROCESS.


## FIX for config refusing to load dupon startup: reload eww

