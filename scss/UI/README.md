# `UI/`
This folder contains basic styling for UI elements. It handles things like position, layout, dimensions, event handlers, etc. These stylesheets do not define colors, animations, or other theme-defined styles; these files merely call the definitions from the selected theme. Themes that wish to override the styles set by these files should `@import` only the files they need, rather than the `main.scss` file.

## `bingleWindow.scss`
Styles the appearance of application windows.

## `button.scss`
Styles buttons.

## `context.scss`
Styles the context menu.

## `desktop.scss`
styles the root window of the desktop.

## `dialog_Auth.scss`
Styles the auth popup.

## `dock.scss`
Styles the dock and its built-in elements. This file does not style widgets.

## `icon.scss`
Handles icon stylings.

## `input.scss`
Styles input fields.

## `main.scss`
Acts as an index for all other stylesheets in this directory.

## `menuStart.scss`
Styles the start menu.

## `systemControl.scss`
Styles the icons and menus of the system tray items.

## `winControls.scss`
Styles the window control buttons.

## `winTab.scss`
Styles tabs.
