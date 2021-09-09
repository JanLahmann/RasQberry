#!/bin/bash
#
echo; echo; echo "IBM Quantum Composer"

cd ~


# check touchscreen calibration
if [ ! -f /home/pi/RasQberry/.is_tft_calibrated ]; then
   whiptail --msgbox "Touchscreen not calibrated." 20 60 1
fi

[ -f /home/pi/nohup.out ] && rm -f /home/pi/nohup.out
setsid nohup chromium-browser --start-fullscreen --enable-webgl --ignore-gpu-blacklist  http://quantum-computing.ibm.com/composer/new &
sleep 6
