store this COMMAND as a string in tab json for per-instance use. Eww will execute this periodically.

`ls -lh1{{ARG.showHidden ?: 'ERROR'}{{ARG.sortReverse ?: 'ERROR'} == true ? 'r' : ''} == true ? 'A' : ''} --sort={ARG.sortMode ?: 'none'} ${CWD}`

replace ERROR with false after debugging.
