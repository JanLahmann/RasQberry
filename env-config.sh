#!/bin/sh
export $(grep -v "^#" "$RASQ_PATH/environment.env" | xargs -d "\n")
