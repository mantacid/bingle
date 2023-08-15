## TO VOID:
add an image wallpaper.png to the root of the repo, as ive put it in the .gitignore file so that we arent uploading images. you'll need gtk3 installed (should be a dependency of eww.)

# BINGLE
BINGLE (Badly INtegrated Graphical Linux Environment) is less of a legitimate desktop environment and more of an experiment. It is written to utilize [Elkowar's Wacky Widgets](https://github.com/elkowar/eww), and is integrated with the system through a bunch of janky scripts.

It takes a unique approach to its UI, taking inspiration from the [AvdanOS concept video](https://www.youtube.com/watch?v=tXFEiw1aJTw), with a few of my own twists:

- Tabs can be dragged to the taskbar to turn them into inline widgets.
- Tabs can be dragged to the desktop to make widgets there
- Tabs containing different applications can share a window
- The desktop can move out of the way to reveal user-made content, such as a menu, system information, really anything that can be made with EWW can be substituted in for anything else.
- context menus can use arbitrary yuck in their options, such as an inline color picker for example.

Things BINGLE cannot do:
- Support a native web browser. EWW doesn't have a way to render HTML.
- Act as a compositor. Imagemagick can be added to the project to fake it though.

## DEPENDENCIES
- [xdotool](https://github.com/jordansissel/xdotool) (for X11 desktops)
