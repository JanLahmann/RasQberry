#!/bin/sh
export $(grep -v "^#" "/home/pi/RasQberry/rasqberry_environment.env" | xargs -d "\n")
