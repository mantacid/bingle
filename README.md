# BINGLE
> NOTE: I am currently in the process of redoing the ENTIRE backend in lisp, which would allow for the dynamic generation of yuck, easy tab dragging, and less of a relianceon the `/tmp` directory. I will update the documentation to reflect these changes when they are made.

BINGLE (Badly INtegrated Graphical Linux Environment) is less of a legitimate desktop environment and more of an experiment. It is written to utilize [Elkowar's Wacky Widgets](https://github.com/elkowar/eww), and is integrated with the system through a bunch of janky scripts.

It takes a unique approach to its UI, taking inspiration from the [AvdanOS concept video](https://www.youtube.com/watch?v=tXFEiw1aJTw), as well as from the HaikuOS window manager, with a few of my own twists:

- Tabs can be dragged to the taskbar to turn them into inline widgets.
- Tabs can be dragged to the desktop to make widgets there
- Tabs containing different applications can share a window
- The desktop, being defined with yuck, can be replaced with other widgets. For example, it could be made to move out of the way to reveal user-made content, such as a menu, system information, really anything that can be made with EWW can be substituted in for anything else.
- context menus can use arbitrary yuck in their options, such as an inline color picker for example.

Things BINGLE cannot do:
- Support a native web browser. EWW doesn't have a way to render HTML. If anyone knows of a way to use GTK to render a webpage that a browser can interact with, please tell me. 
- Act as a compositor. Compositing is usually handled by a window manager. However, Imagemagick can be added to the project to fake things like blur, though doing so in real time is not feasable for all machines.

## DOCUMENTATION:
The documentation is still very much a work in progress.
There are, however, brief explanatory files placed in their relevant directories, as well as a copious amounts of comments in the code.
Documentation will be consolidated in the near future.

## DEPENDENCIES
As of this writing, there are no plans to create a script that will install all the dependencies. This task is left to the user, but guidance will be provided if necessary.
- [xdotool](https://github.com/jordansissel/xdotool) (gets mouse cursor & screen information on systems that use X11.)
- imagemagick (for wallpaper blurring)
- [fswatch 1.17.1](https://github.com/emcrisostomo/fswatch) (tracks config file changes)

# Repository Structure
Each directory will have a README file explaining its purpose and contents.

## `conf/`
Contains files used to define the behavior of the system. Work is being done to create a central config file for the entire system, along with a handler function that can pull from it.

## `programs/`
contains various native BINGLE applications. WIP.

## `res/`
Contains assets used by the system, such as the wallpapers, the BINGLE icon, and others.

## `scripts/`
Contains helpful scripts and utilities.

## `scss/`
Contains stylesheets, themes, and useful scss functions.

## `yuck/`
Contains yuck to render the UI and applications.

# NOTES for the DEVS:
- window content should use a literal that pulls from the json of the active tab, so that app yuck and data can all be transferred at once.
