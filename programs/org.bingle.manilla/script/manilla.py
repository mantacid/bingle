#!/usr/bin/env python

#####################################################################################
## IMPORTS ##
from subprocess import PIPE, Popen
import json
import re
#import breadcrumb

#####################################################################################
## get():
## gets info about the contents of a directory.
## takes in an absolute path and some options
##
def get(path, sort="none", time="mtime", showHidden=False, isReversed=False):
  ## handle the showHidden option
  ## accepts a boolean
  if showHidden:
    showHidden_STR = "A" ## "A"
  else:
    showHidden_STR = ""

  ## handle the reverse option
  ## accepts a boolean
  if isReversed:
    isReversed_STR = "r" ## "-r"
  else:
    isReversed_STR = ""

  ## check if sort=time, get the value of the time option if it is.
  if str(sort) == "time":
    sort_STR = " --sort=" + str(sort)## + " --time=" + str(time)
    time_STR = " --time=" + str(time)
  elif len(str(sort)) > 0:
    sort_STR = " --sort=" + str(sort)
    time_STR = " --time=mtime"
  else:
    sort_STR = " --sort=none"
    time_STR = " --time=mtime"

  ## construct the list containing the arguments to the bash command.
  CMD_STR = "ls -l1h --time-style=long-iso " + str(showHidden_STR) + str(isReversed_STR) + str(sort_STR) + str(time_STR) + " " + str(path)
  ## run the command, store output in string.
  with Popen(CMD_STR, stdout=PIPE, stderr=None, shell=True) as process:
    output = process.communicate()[0].decode("utf-8")
    #print(output)
  return output

#####################################################################################
## pack():
## package the output of an ls command into json
## takes a string as input.
## outputs a JSON string
def pack(data, path):
  ## split the data by newlines.
  file_LIST = re.split("\n", data)

  ## discard the first and last items. we don't need them.
  file_LIST.pop(0)
  file_LIST.remove("")
  ## define regex pattern to create tuples containing the relevant data for each file.
  PATTERN = r'^([\-bcdlnps])([\-rwxt]{3})([\-rwxt]{3})([\-rwxt]{3})[\s]+([\d\s]+)[\s]+(\b[\w]+\b)[\s]+(\b[\w]+\b)[\s]+([\d\w\.]+)[\s]+(\b[\d]{4})[\-]([\d]{2})[\-]([\d]{2})[\s]([\d:]{5})[\s]+([\w\d\-_\. ]+)'

  ## define a list of names to pull keys from. this also serves as a reference for what values we're looking at.'
  key_LIST = ["type", "owner-perm", "group-perm", "other-perm", "item-count", "ownerU", "ownerG", "size", "year", "month", "day", "time", "name"]
  ## define containing JSON structure
  attr_LIST = []
  ## iterate through list, matching relevant info
  for file_data_STR in file_LIST:
    data_ARR = re.findall(PATTERN, file_data_STR)
    data_TUPLE = data_ARR[0]
    data_dict = {}
    ## before getting all the other values, get the file's mimetype
    File = str(path) + "/" + str(data_TUPLE[-1])
    CMD_STR = "file -b --mime-type " + str(File)
    ## run above command in bash to get the mimetype
    with Popen(CMD_STR, stdout=PIPE, stderr=None, shell=True) as process:
      output = process.communicate()[0].decode('utf-8')
      ## format output to remove newline
      mimetype = re.sub(r'\n', "", output)
      ## write mimetype to dictionary
      data_dict["mimetype"] = mimetype
      ## loop over the rest of the data provided by ls
    for j in range(len(data_TUPLE)):
      key = key_LIST[j]
      data_dict[key] = data_TUPLE[j]
    ## append the dict to the attr_LIST
    attr_LIST.append(data_dict)
  ## dump the JSON string
  return_JSON = json.dumps(attr_LIST, separators=(",", ":"))
  #print(return_JSON)
  return return_JSON
