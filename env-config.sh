#!/bin/sh
export $(grep -v "^#" "/home/pi/RasQberry/environment.env" | xargs -d "\n")
