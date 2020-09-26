#!/bin/bash
#
echo; echo; echo "Bloch Sphere Demo"

export DISPLAY=:0
cd ~

# check if GL2/GL3 driver is enabled
[ ! -f /home/pi/RasQberry/.kms-gl-enabled ] && (whiptail --msgbox "GL driver not enabled. Bloch demo needs to be run once from rasqberry-config" 20 60 1; exit 1)
# check touchscreen calibration
[ ! -f /home/pi/RasQberry/.is_tft_calibrated ] &&  (whiptail --msgbox "Touchscreen not calibrated. Bloch demo needs to be run once from rasqberry-config" 20 60 1; exit 1)
# check if Bloch demo is installed
[ ! -d rasqberry-grok-bloch ] && (whiptail --msgbox "Bloch demo code not downloaded. Bloch demo needs to be run once from rasqberry-config" 20 60 1; exit 1)



cd rasqberry-grok-bloch/
if [ -f rasqberry-bloch-isrunning ]; then
   kill -15 `cat rasqberry-bloch-isrunning`
   rm rasqberry-bloch-isrunning
fi

nohup python3 -m http.server 8000 &
echo $! > rasqberry-bloch-isrunning
#nohup chromium-browser --start-fullscreen --no-sandbox --enable-webgl --ignore-gpu-blacklist --test-type  http://127.0.0.1:8000 &
setsid nohup chromium-browser --start-fullscreen --enable-webgl --ignore-gpu-blacklist  http://127.0.0.1:8000 &
echo $! >> rasqberry-bloch-isrunning
sleep 10
#whiptail --msgbox "Please wait until BlochSphere Demo has started" 20 60 1
