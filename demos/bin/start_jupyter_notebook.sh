#!/bin/bash
#
# Start the Jupyter Notebook

export PATH=/home/pi/.local/bin:/home/pi/RasQberry/demos/bin:$PATH
nohup jupyter notebook &

sleep 2