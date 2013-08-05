#!/bin/bash

# Render a sprint review to html.

REVIEW=$1
xsltproc "style/slides.xsl" "${REVIEW}/sprint-review.xml" > "${REVIEW}/sprint-review.html" 
