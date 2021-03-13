#!/bin/bash
#
echo; echo; echo "Bloch Sphere Demo"

export DISPLAY=:0
cd ~


# check touchscreen calibration
if [ ! -f /home/pi/RasQberry/.is_tft_calibrated ]; then
   whiptail --msgbox "Touchscreen not calibrated. Bloch demo needs to be run once from rasqberry-config" 20 60 1
   exit 1
fi



nohup python3 -m http.server 8000 &
#nohup chromium-browser --start-fullscreen --no-sandbox --enable-webgl --ignore-gpu-blacklist --test-type  http://127.0.0.1:8000 &
setsid nohup chromium-browser --start-fullscreen --enable-webgl --ignore-gpu-blacklist  http://quantum-computing.ibm.com/composer/new &
sleep 6
#whiptail --msgbox "Please wait until BlochSphere Demo has started" 20 60 1
