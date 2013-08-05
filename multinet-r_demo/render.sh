#!/bin/bash

# Render a sprint review to html.
BASE_DIR=$(dirname $0)
REVIEW_DIR=$1
xsltproc "${BASE_DIR}/deck/slides.xsl" "${REVIEW_DIR}/multinet-r_demo.xml" > "${REVIEW_DIR}/multinet-r_demo.html"
