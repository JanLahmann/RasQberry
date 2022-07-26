#!/bin/sh

SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
RASQ_PATH=$(dirname "$SCRIPT")
echo "$RASQ_PATH"
export RASQ_PATH

export $(grep -v "^#" "$RASQ_PATH/environment.env" | xargs -d "\n")
