#!/usr/bin/env python
import json
import sys

## arg1 is the path to the window file
winTabs = sys.argv[1]
## json to insert into the list is arg2
tabJSON = sys.argv[2]
## string contained by winTabs makes up arg3
winJSON = sys.argv[3]

## load both tab and window json into python dicts
winDICT = json.loads(winJSON)
tabDICT = json.loads(tabJSON)

## get the list inside the winJSON
winLIST = winDICT["tabs"]

## append tabDICT to the end of the winLIST
winLIST.append(tabDICT)
## update winDICT
winDICT["tabs"] = winLIST

## write the new data to the file
f = open(winTabs, "wt")
f.write(winDICT)
f.close()
