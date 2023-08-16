IMPORTANT GENIUS SOLUTION FOR TAB TRANSFER SCHEME THAT YOU CANNOT FORGET UNDER ANY CIRCUMSTANCES!!!!!!!!

every window will come with a file that is named after its own winUUID. this file contains all of the tabs in that window, keyed with their tabUUID. Each entry is a json structure, so that it can contain both the tab data and the associated content, and still integrate well into eww itself.

tab when dragged will pass strign of its original winUUID and its tabUUID.

tabzone :ondropped event will call a script &pass the two UUIDs as two arguments.

the script will search in the file ${winUUID} for the string that contains the ${tabUUID} and moves the whole yuck entry from the old window file to its OWN file!

since each window renders tabs from their own file, this solves both the dynamic content issue AND the data transfer issue.
