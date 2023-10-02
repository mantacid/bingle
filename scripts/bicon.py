#!/usr/bin/env python

## BIngle CONfigurator
## Author: Mantacid

import tempfile as tmp
import sys
import json
import re
from pandas import json_normalize
from subprocess import PIPE, Popen

################################################################################
## format json string to have no whitespace outside of strings.
def dict_format(JSON_STR):
  #JSON_STR = re.sub(r"\n", "", JSON_STR)                    ## remove newlines
  #JSON_STR = re.sub(r"(?<![\[\"\w\d])\s+", "", JSON_STR)    ## remove \ and indents
  #JSON_STR = re.sub(r"\s}", "", JSON_STR)                   ## remove spaces not in ""
  temp = tmp.NamedTemporaryFile(prefix="bicon")
  with open(temp.name, 'w') as f:
    f.write(JSON_STR)
  with open(temp.name, 'rt') as f:
    #print(type(f))
    #print(f.name)
    #print(repr(open(f.name, 'rb').read()))
    DICT = json.load(f)
  #DICT = json.load(temp)
  return DICT

# ################################################################################
# ## format json string for use in yuck/ temp config.
# ## where tf do i use this function?
# def yuck_format(JSON_STR):
#   ## format the string
#   JSON_STR = re.sub(r"\n", "", JSON_STR)                    ## remove newlines
#   JSON_STR = re.sub(r"(?<![\[\"\w\d])\s+", "", JSON_STR)    ## remove \ and indents
#   JSON_STR = re.sub(r"\s}", "", JSON_STR)                   ## remove spaces not in ""
#
#   return JSON_STR

################################################################################
## parses Pretty json file into python dict for easy manipulation. This means we dont get live config updates, but it also means we aren't writing to the disk as much.
def parse(JSON_PATH):

  ## OPEN file at JSON_PATH
  with open(JSON_PATH, 'r') as f:
    json_str = f.read()
    CONF_DICT = dict_format(json_str)
  return CONF_DICT

################################################################################
## update the value of KEY in DICT to VAL. returns updated DICT
def update(DICT, KEY, VAL):
  DICT.KEY = VAL
  return DICT

################################################################################
## internal function. prints full expanded names of keys in dot notation. try to not call this on its own.
def walk_keys(OBJ):
  #print("OBJ:" + str(type(OBJ)))
  ## make OBJ into a python dict. THIS THING IS DRIVING ME INSANE
  LIST = json.loads(OBJ)
  ToC = json_normalize(LIST, sep='.')
  print(type(ToC))
  print(repr(ToC))
  return ToC ## return DataFrame. format this later to give to yuck to guide iteration

################################################################################
## Print a list of all expanded keys in file at PATH using dot notation, add output to list defined in LIST. This should be called by the yuck to get a list of keys to iterate through, It should NOT be used to initialize the temp config!!!!
def trace(PATH, LIST):
  DICT = parse(PATH)
  #print(type(DICT))
  obj = json.dumps(DICT)
  for s in walk_keys(obj):
    LIST.append(s)
  return LIST
################################################################################
## init the config at PATH upon first start, opening a bingle dialog to accept the user input.

def conf_init(PATH):
  ## parse config at PATH
  CONF_DICT = parse(PATH)

  ## loop through all keys, prompt for input of type defined in key name.
  ## we don't know how many nests the json will have (most likely its five, but only if the settings GUI will prohibit user inputs that are dicts. Plus, it would be a good idea for me to future-proof this now.), so use recursion to get all the keys.

################################################################################
## load_to_temp(): loads the config into a temp file
## takes the path to the config as the argument
## returns the temp file name
## THIS FUNCTION MAY BE DEPRECIATED IN THE FUTURE
def load_to_temp(path):
  DICT = parse(path)
  FORM_STR = json.dumps(DICT, separators=(',',':'))
  ## define the command string
  CMD = r"file='/tmp/bingleConf.json'; echo '{S}' >> $file; echo $file"
  CMD_STR = CMD.format(S = FORM_STR)
  with Popen(CMD_STR, stdout=PIPE, stderr=None, shell=True, executable='/bin/bash') as process:
    output = process.communicate()[0].decode("utf-8")
  return output

################################################################################
## load_to_yuck(): directly update the yuck variable storing the config.
## takes the name of the variable (in case another application uses this function to update their config), the new formatted config json STRING, and the eww config. eww config is set to its default location by default
## returns nothing, may be changed to return some status message or something idk man I'm tired.
## ASSUMES THAT THE EWW EXECUTABLE HAS BEEN SYMLINKED TO /usr/local/bin/eww, and that the repo has been symlinked to $HOME/.config/eww
def load_to_yuck(CONF_LOC, YUCK_VAR_NAME='CONF_MAIN', EWW_CONF_DIR_PATH='/$HOME/.config/eww'):
  #CONF_JSON_STR = json.dumps(DATA_DICT, separators=(',',':'))
  #print(CONF_JSON_STR)
  DATA_DICT = parse(CONF_LOC)
  DATA_STR = json.dumps(DATA_DICT, separators=(',', ':'))
  ## structure the command
  CMD = r"eww update -c {ewwConf} {var}={dat}"
  CMD_STR = CMD.format(ewwConf = EWW_CONF_DIR_PATH, var = YUCK_VAR_NAME, dat = DATA_STR)
  with Popen(CMD_STR, stdout=PIPE, stderr=None, shell=True, executable='/bin/bash') as process:
    output = process.communicate()[0].decode("utf-8")
  #return output

################################################################################
## DEBUG CALLS
#A = ['']
#X = "/home/bingle/github/bingle/conf/main.json"
#print(X)
#Y = parse(X)
#print(Y)
#Z = trace(X, A)
#print(Z)
#print(A)
################################################################################
## MAIN CALLS ##
CONF_PATH = sys.argv[1]
CONF_DICT = parse(str(CONF_PATH))
JSON_STR = json.dumps(CONF_DICT, separators=(',',':'))
print(JSON_STR)
