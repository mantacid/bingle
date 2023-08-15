.inj/ contains yuck that will be updated by various scripts, allowing arguments to be passed to widgets from a command line.

This is accomplished by updating the yuck variables with the outputs of various scripts.

EXAMPLE: to pass the relevant menu options to a newly-spawned instance of a context-menu, we can use a script to parse into yuck the options provided by the right click target, from which the widget will include the values.

Alternatively, one could update some json and pass it through that way.

This is a temporary hack, and hopefully a more tidy fix can be found.
