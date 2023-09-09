# BINGLE
BINGLE (Badly INtegrated Graphical Linux Environment) is less of a legitimate desktop environment and more of an experiment. It is written to utilize [Elkowar's Wacky Widgets](https://github.com/elkowar/eww), and is integrated with the system through a bunch of janky scripts.

It takes a unique approach to its UI, taking inspiration from the [AvdanOS concept video](https://www.youtube.com/watch?v=tXFEiw1aJTw), with a few of my own twists:

- Tabs can be dragged to the taskbar to turn them into inline widgets.
- Tabs can be dragged to the desktop to make widgets there
- Tabs containing different applications can share a window
- The desktop can be made to move out of the way to reveal user-made content, such as a menu, system information, really anything that can be made with EWW can be substituted in for anything else.
- context menus can use arbitrary yuck in their options, such as an inline color picker for example.

Things BINGLE cannot do:
- Support a native web browser. EWW doesn't have a way to render HTML.
- Act as a compositor. Imagemagick can be added to the project to fake things like blur though.

## DEPENDENCIES
- [xdotool](https://github.com/jordansissel/xdotool) (gets mouse cursor & screen information on systems that use X11.)

# Repository Structure
Each directory will have a README file explaining its purpose and contents.

## `conf/`
Contains files used to define the behavior of the system.

## `programs/`
contains various native BINGLE applications. WIP.

## `res/`
Contains assets used by the system, such as the wallpaper, BINGLE icon, and others.

## `scripts/`
Contains helpful scripts and utilities.

## `scss/`
Contains stylesheets.

## `yuck/`
Contains yuck to render the UI and applications.

# NOTES for the DEVS:
- window content should use a literal that pulls from the json of the active tab, so that app yuck and data can all be transferred at once.
