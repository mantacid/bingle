#!/usr/bin/env/python

#####################################################################################
## IMPORTS ##
import sys
import json
import re

#####################################################################################
## depth()
## takes in an absolute path to a directory.
## returns the depth of that directory. It includes the root directory in this count.
def depth(path):
  ## find the depth of the directory, relative to root.
  ## do this by counting the regex matches of the below pattern
  pattern_depth = '([\w\d\-\._ ]+)*(/)*'
  match_LIST = re.findall(pattern_depth, path)
  #print(repr(match_LIST))
  ## count the depth, subtract 1 to both compensate for empty match at the end, and to account for the first index being 0.
  depth = len(match_LIST) - 1
  return depth

#####################################################################################
## make()
## takes in an absolute path to a directory.
## returns a JSON STRING containing the absolute paths of each parent directory
def make(path):
  ## create a list to hold the paths to be returned.
  return_DICT = {"crumbs":[]}
  ## get the depth of the path
  count = depth(path)
  ## iterate through path
  for x in range(count):
    ## build regex pattern based on for-loop index
    pattern = r'(^(/)*(/[\w\d\.\-_ ]+){' + re.escape(str(x)) + r'})'
    ## match the pattern
    match = re.findall(pattern, path)
    #print(repr(match))
    ## list elements are tuples, but the path we want is always the first item in said tuple, and the name to display is always the last item.
    match_tuple = match[0]
    traced_path = str(match_tuple[0])
    if len(str(match_tuple[-1])) > 0:
      ## get the last tuple item
      name_unformatted = str(match_tuple[-1])
      if x == count - 1:
        ## leave the trailing / off of the end of the name
        traced_name = re.sub(r"(/)(\b[\w\d\-\._ ]+)", r"\g<2>", name_unformatted)
      else:
        traced_name = re.sub(r"(/)(\b[\w\d\-\._ ]+)", r"\g<2>/", name_unformatted)
    else:
      ## if the last tuple item is empty, we must be on the first tuple. Get the second tuple item instead of the last one.
      traced_name = str(match_tuple[1])
    ## create and populate a mini-dictionary to hold all the data
    miniDICT = {"name":"","path":""}
    miniDICT["name"] = traced_name
    miniDICT["path"] = traced_path
    ## assign the data to the return_dict
    return_DICT["crumbs"].append(miniDICT)
  ## format the json into a string that eww can read.
  STR_FOR_EWW = json.dumps(return_DICT, separators=(",",":"))
  print(repr(STR_FOR_EWW))
  return STR_FOR_EWW
