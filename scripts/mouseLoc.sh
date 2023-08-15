#!/bin/bash
## get mouse data as space-delineated string
##MOUSEPOLL=$(echo "$(xdotool getmouselocation)" | sed 's/x://g; s/y://g; s/screen://g; s/window://g; s/ /${nl}')
eval $(xdotool getmouselocation --shell --prefix BINGLE_)
mX() {
  echo "$BINGLE_X"
}

mY() {
  echo "$BINGLE_Y"
}

mScreen() {
  echo "$BINGLE_SCREEN"
}

mWindow() {
  echo "$BINGLE_WINDOW"
}

mCoords() {
  echo "${BINGLE_X}x${BINGLE_Y}"
}

while getopts 'xyswc' OPT; do
  case "$OPT" in
    x)
      mX
      ;;
    y)
      mY
      ;;
    s)
      mScreen
      ;;
    w)
      mWindow
      ;;
    c)
      mCoords
      ;;
    ?)
      echo "wrong flag provided"
      exit 1
  esac
done
