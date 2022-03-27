#!/bin/bash
#
echo; echo; echo "IBM Quantum Composer"

cd ~

[ -f /home/pi/nohup.out ] && rm -f /home/pi/nohup.out
setsid nohup chromium-browser --start-fullscreen --enable-webgl --ignore-gpu-blacklist  http://quantum-computing.ibm.com/composer/new &
sleep 6
