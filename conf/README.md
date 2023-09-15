# `conf/`
this folder contains all config files for the bingle system. One can update these values manually with any text editor. There are plans to implement a handler script for this purpose, along with a native settings manager to utilize the handler script.

## `accessibility.yuck`
Defines global settings that make the system easier to use by users with disabilities. This is still being worked on, so it may be sparse right now.

## `app-layouts.yuck`
WIP. Will define window tiling layouts.

## `bingleWindow.yuck`
defines settings having to do with application windows, such as frame size and window gaps.

## `desktop.yuck`
Sets the desktop Background.

## `dock.yuck`
Dock-related config values. Will become more useful when the dock is actually finished.

## `look.yuck`
Sets system theme.

## `main.json`
THESE FEATURES ARE PLANNED, NOT CURRENTLY IMPLEMENTED!
JSON file that contains all bingle settings. Work is being done to transfer all settings to this file. a handler script will ensure that the settings get applied to their respective files (and to remove whitespace when sending it to eww).

### Initialization
Upon first booting up the environment or an application, the handler will read the entire config. If it runs into a value of type `null`, it wil prompt the user to choose a value for that setting. This is mainly to allow users to set things that would be important to them, *before* the environment/application starts.

### Structure
The hierarchy of settings is as follows:
`org.ORGANIZATION.PROGRAM.TYPE.KEY`
for example: assigning a value to `org.bingle.desktop.yuck.str_wp-path` would set the path to the desktop wallpaper.

Each key has the expected json datatype for its value prepended to the key's name.

## `main.yuck`
Index file for all configurations. (may be phased out in favor of a json format.)

## `system.yuck`
Define system variables like the current user icon.
