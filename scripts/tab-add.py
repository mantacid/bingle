#!/usr/bin/env python
import json
import sys
## ARGUMENTS ##
#winTabsPATH = sys.argv[1] ## path to window's tabs.json file.
winPATH = sys.argv[1] + "/" ##path to the window dir
tabBasePATH = sys.argv[2] ## path to the json template (path)
tabUUID = sys.argv[3]
tabLabl = sys.argv[4]
tabIcon = sys.argv[5]
#tabCont = sys.argv[6] ## STILL NOT WORKING FOR SOME REASON

## PROCESSING THE DATA ##
winTabsPATH = winPATH + "tabs.json"
## Get python dictionaries from the last two arguments.
with open(winTabsPATH, 'r') as win, open(tabBasePATH, 'r') as tab:
  winTabsSTR = win.read()
  tabBaseSTR = tab.read()

  while True:
    if winTabsSTR:
      winDICT = json.loads(winTabsSTR)
      #print(winDICT)
      break
    else:
      print("ERROR: Cannot parse JSON in the window tabs json string. Make sure the template is formatted correctly and that there is no whitespace in the JSON outside of string values")

  while True:
    if tabBaseSTR:
      tabDICT = json.loads(tabBaseSTR)
      #print(tabDICT)
      break
    else:
      print("ERROR: Cannot parse the tab json string. make sure it is properly formatted and there is no whitespace in the json outside of string values.")

## alter the base tab json to include the values passed in other arguments
tabDICT['uuid'] = tabUUID
tabDICT['name'] = tabLabl
tabDICT['icon'] = tabIcon
tabDICT['currentWindow'] = winPATH
#tabDICT['content'] = tabCont

## initial template value is empty string, as apparently lists in python dicts aren't trivial.
winDICT['tabs'] = []
tabLIST = winDICT['tabs']
tabLIST.append(tabDICT)
print(winDICT)

## Write the new data to the tab json file
with open(winTabsPATH, 'wt') as tabs:
  tabs.write(json.dumps(winDICT))
