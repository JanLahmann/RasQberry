#!/bin/sh
# shellcheck disable=SC2046
export $(grep -v "^#" "/home/pi/RasQberry/rasqberry_environment.env" | xargs -d "\n")
