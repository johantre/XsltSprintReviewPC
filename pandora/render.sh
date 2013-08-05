#!/bin/bash

# Render a sprint review to html.
BASE_DIR=$(dirname $0)
REVIEW_DIR=$1
shift

xsltproc $@ "${BASE_DIR}/deck/slides.xsl" "${REVIEW_DIR}/sprint-review.xml" > "${REVIEW_DIR}/sprint-review.html"
