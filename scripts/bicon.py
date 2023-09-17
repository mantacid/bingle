#!/usr/bin/env python

## BIngle CONfigurator
## Author: Mantacid

import tempfile as tmp
import sys
import json
import re
from pandas import json_normalize

#################################################################################
## format json string to have no whitespace outside of strings.
def cleanup(JSON_STR):
  #JSON_STR = re.sub(r"\n", "", JSON_STR)                    ## remove newlines
  #JSON_STR = re.sub(r"(?<![\[\"\w\d])\s+", "", JSON_STR)    ## remove \ and indents
  #JSON_STR = re.sub(r"\s}", "", JSON_STR)                   ## remove spaces not in ""

  temp = tmp.NamedTemporaryFile(prefix="bingle")
  with open(temp.name, 'w') as f:
    f.write(JSON_STR)
  with open(temp.name, 'rt') as f:
    #print(type(f))
    #print(f.name)
    #print(repr(open(f.name, 'rb').read()))
    DICT = json.load(f)
  #DICT = json.load(temp)
  return DICT

#################################################################################
## parses Pretty json file into python dict for easy manipulation. This means we dont get live config updates, but it also means we aren't writing to the disk as much.
def parse(JSON_PATH):

  ## OPEN file at JSON_PATH
  with open(JSON_PATH, 'r') as f:
    json_str = f.read()
    CONF_DICT = cleanup(json_str)
  return CONF_DICT

#################################################################################
## update the value of KEY in DICT to VAL. returns updated DICT
def update(DICT, KEY, VAL):
  DICT.KEY = VAL
  return DICT

#################################################################################
## internal function. prints full expanded names of keys in dot notation. try to not call this on its own.
def walk_keys(OBJ):
  #print("OBJ:" + str(type(OBJ)))
  ## make OBJ into a python dict. THIS THING IS DRIVING ME INSANE
  LIST = json.loads(OBJ)
  ToC = json_normalize(LIST, sep='.')
  print(type(ToC))
  print(repr(ToC))
  return ToC ## return list

#################################################################################
## Print a list of all expanded keys in file at PATH using dot notation, add output to list defined in LIST
def trace(PATH, LIST):
  DICT = parse(PATH)
  #print(type(DICT))
  obj = json.dumps(DICT)
  for s in walk_keys(obj):
    LIST.append(s)
  return LIST
#################################################################################
## init the config at PATH upon first start, opening a bingle dialog to accept the user input.

def init(PATH):
  ## parse config at PATH
  CONF_DICT = parse(PATH)

  ## loop through all keys, prompt for input of type defined in key name.
  ## we don't know how many nests the json will have (most likely its five, but only if the settings GUI will prohibit user inputs that are dicts. Plus, it would be a good idea for me to future-proof this now.), so use recursion to get all the keys.

#################################################################################
## DEBUG CALLS
A = ['']
X = "/home/bingle/github/bingle/conf/main.json"
#print(X)
Y = parse(X)
#print(Y)
Z = trace(X, A)
#print(Z)
#print(A)
