#!/bin/sh

# Absolute path this script is in
RASQ_PATH="$(dirname "$(readlink -e -- "$0")")/RasQberry"
echo "$RASQ_PATH"

export $(grep -v "^#" "/home/pi/RasQberry/environment.env" | xargs -d "\n")
