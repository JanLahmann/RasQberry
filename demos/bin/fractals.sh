#!/bin/bash
#
echo; echo; echo "Fractals Demo"

# check if Initial Setup is done
if [ "$REQUIREMENTS_INSTALLED" = false ]; then
  do_rasqberry_install_requirements
fi
sudo apt-get install chromium-chromedriver
cd /home/pi/RasQberry/demos/bin/fractal_files || exit
sudo -u pi -H -- sh -c '/usr/bin/python3 /home/pi/RasQberry/demos/bin/fractal_files/fractals.py'
cd || exit
