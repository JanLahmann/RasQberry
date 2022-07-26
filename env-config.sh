#!/bin/sh

# Absolute path this script
RASQ_PATH=$(realpath $0)
echo "$RASQ_PATH"
export RASQ_PATH

export $(grep -v "^#" "$RASQ_PATH/environment.env" | xargs -d "\n")
