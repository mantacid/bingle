import os
import json
import re

## get parent directory
path = os.getcwd()
BINGLE_CONFIG_DIR = os.path.dirname(path)

## define globals
winYuck_base = '''(defwindow WINDOW :geometry (geometry :x "10%"
                                      :y "10%"
                                      :width "60%"
                                      :height "40%"
                                      :anchor "top left"
                            )
                   :wm-ingore false
                   :stacking "bg"
                   :windowtype "normal"
  (winBingle :content-yuck "(context)")
)'''

def winOpen():
  ## create the windnow uuid
  winUUID = os.system("uuidgen")
  print(winUUID)

  ## create window from yuck with UUID
  winYuck = re.sub('WINDOW', winUUID, winYuck_base, 1)

  ## create the window
  tmpPath = BINGLE_CONFIG_DIR / "tmp" / winnUUID
  winFile = open(tmpPath, "w")


winOpen()
