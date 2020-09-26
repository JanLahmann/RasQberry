#!/bin/bash
#
echo; echo; echo "Bloch Sphere Demo"

export DISPLAY=:0
cd ~

# check if GL2/GL3 driver is enabled
[ ! -f /home/pi/RasQberry/.kms-gl-enabled ] && whiptail --msgbox "1. Bloch demo needs to be run once from rasqberry-config" 20 60 1
# check touchscreen calibration
[ -f /home/pi/RasQberry/bin/rq_99-calibration.conf ] &&  whiptail --msgbox "2. Bloch demo needs to be run once from rasqberry-config" 20 60 1


if [ ! -d rasqberry-grok-bloch ]; then
whiptail --msgbox "git clone" 20 60 1
   git clone https://github.com/JanLahmann/rasqberry-grok-bloch;
fi


cd rasqberry-grok-bloch/
if [  ! -f rasqberry-bloch-isrunning ]; then
whiptail --msgbox "before http" 20 60 1
   nohup python3 -m http.server 8000 &
   echo $! > rasqberry-bloch-isrunning
whiptail --msgbox "before chrome" 20 60 1
#   nohup chromium-browser --start-fullscreen --no-sandbox --enable-webgl --ignore-gpu-blacklist --test-type  http://127.0.0.1:8000 &
   nohup chromium-browser --start-fullscreen --enable-webgl --ignore-gpu-blacklist  http://127.0.0.1:8000 &
   echo $! >> rasqberry-bloch-isrunning
else
whiptail --msgbox "before kill" 20 60 1
   kill -15 `cat rasqberry-bloch-isrunning`
   rm rasqberry-bloch-isrunning
fi
