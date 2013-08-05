#!/bin/bash

# Listen and render sprint review page to HTML.

REVIEW=$1
while true; do
  inotifywait -e modify "./${REVIEW}/sprint-review.xml"
  ./render1.sh "${REVIEW}"
  #google-chrome "./${REVIEW}/sprint-review.html"
done
