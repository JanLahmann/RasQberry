#!/bin/bash
#
echo; echo; echo "Fractals Demo"

cd /home/pi/RasQberry/demos/bin/fractal_files || exit
sudo -u pi -H -- sh -c '/usr/bin/python3 /home/pi/RasQberry/demos/bin/fractal_files/fractals.py'
cd || exit
