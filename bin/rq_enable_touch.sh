#!/bin/bash
#
cd ~/
[ -d Tools ] || mkdir Tools
cd Tools
[ -d LCD-show ] && ( echo "Automatic display configuration not possible" ) || ( git clone https://github.com/goodtft/LCD-show && touch /home/pi/RasQberry/.is_enabled_touch4 && cd LCD-show/ && sudo ./MPI4008-show 180 )
