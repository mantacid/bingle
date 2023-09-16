#!/usr/bin/env bash

## Load the wallpaper and dock
## NOTE: this assumes that you have symlinked the following:
### eww executable ====> /usr/local/bin/eww
### bingle repo =======> ~/.config/eww/

## If you have to keep the default eww configs for whatever reason, edit the command to include the -c flag with the desired config directory.

eww open DESKTOP DOCK
#eww -c path/to/the/bingle/repo open DESKTOP DOCK

## TODO: init the configs, formatting them and placing them into \tmp
