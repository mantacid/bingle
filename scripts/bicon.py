#!/usr/bin/env python

## BIngle CONfigurator
## Author: Mantacid

import sys
import json
import re

#################################################################################
## format json string to have no whitespace outside of strings.
def format(JSON_STR):
  x = json.dumps(JSON_STR, separators=(',', ':'), indent=None)
  ## regex junk away
  x = re.sub(r"(\\n)[\s]*(\\?)", "", x)
  x = re.sub(r"\\", "", x)
  return x

#################################################################################
## parses Pretty json file into python dict for easy manipulation. This means we dont get live config updates, but it also means we aren't writing to the disk as much.
def parse(JSON_PATH):

  ## OPEN file at JSON_PATH
  with open(JSON_PATH, 'r') as f:
    json_str = f.read()
    CONF_DICT = format(json_str)
  return CONF_DICT

#################################################################################
## update the value of KEY in DICT to VAL. returns updated DICT
def update(DICT, KEY, VAL):
  DICT.KEY = VAL
  return DICT

#################################################################################
## internal function. prints full expanded names of keys in dot notation. try to not call this on its own.
def walk_keys(OBJ, path=""):
  if isinstance(OBJ, dict):
    for k, v in obj.iteritems():
      yield from walk_keys(v, path + "." + k if path else k)
  elif isinstance(OBJ, list):
    for i, v in enumerate(OBJ):
      s = "[" + str(i) + "]"
      yield from walk_keys(v, path + s if path else k)
  else:
    yield path

#################################################################################
## Print a list of all expanded keys in file at PATH using dot notation, add output to list defined in LIST
def trace(PATH, LIST):
  DICT = parse(PATH)
  for s in walk_keys(DICT):
    LIST.append(s)
  return LIST
#################################################################################
## init the config at PATH upon first start, opening a bingle dialog to accept the user input.

def init(PATH):
  ## parse config at PATH
  CONF_DICT = parse(PATH)

  ## loop through all keys, prompt for input of type defined in key name.
  ## we don't know how many nests the json will have (most likely its five, but I want to future-proof this), so use recursion to get all the keys.

#################################################################################
## DEBUG CALLS
A = ['']
X = "/home/bingle/github/bingle/conf/main.json"
print(X)
Y = parse(X)
print(Y)
Z = trace(X, A)
print(Z)
print(A)
