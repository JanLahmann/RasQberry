#!/bin/bash

pip install -U numpy
pip install celluloid
pip install selenium
pip install ipython

nohup python3 /home/pi/RasQberry/demos/bin/fractals.py > /dev/null 2>/dev/null &