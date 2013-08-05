#!/bin/bash

# Listen and render sprint review page to HTML.

REVIEW=$1
while true; do
  inotifywait -e modify "./${REVIEW}/multinet-r_demo.xml"
  ./render.sh "${REVIEW}"
  #google-chrome "./${REVIEW}/multinet-r_demo.html"
done
