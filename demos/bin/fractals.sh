#!/bin/bash
#
echo; echo; echo "Fractals Demo"

# Load environment variables
. /home/pi/RasQberry/env-config.sh
# Load external methods
. /home/pi/RasQberry/config/setup.sh

# check if Initial Setup is done
if [ "$REQUIREMENTS_INSTALLED" = false ]; then
  do_rasqberry_install_requirements
fi

cd /home/pi/RasQberry/demos/bin/fractal_files || exit
sudo -u pi -H -- sh -c '/usr/bin/python3 /home/pi/RasQberry/demos/bin/fractal_files/fractals.py'
cd || exit
