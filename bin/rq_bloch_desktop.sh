#!/bin/bash
#
echo; echo; echo "Bloch Sphere Demo"

export DISPLAY=:0
cd ~


do_rasqberry_run_bloch(){
  # check if GL2/GL3 driver is enabled
  [ ! -f /home/pi/RasQberry/.kms-gl-enabled ] && whiptail --msgbox "Bloch demo needs to be run once from rasqberry-config" 20 60 1
  # check touchscreen calibration
  [ -f /home/pi/RasQberry/bin/rq_99-calibration.conf ] &&  whiptail --msgbox "Bloch demo needs to be run once from rasqberry-config" 20 60 1
  /home/pi/.local/bin/rq_bloch.sh
}
