#!/bin/bash
#
echo; echo; echo "Bloch Sphere Demo"

export DISPLAY=:0
cd ~

if [ ! -d rasqberry-grok-bloch ]; then
   git clone https://github.com/JanLahmann/rasqberry-grok-bloch;
fi


cd rasqberry-grok-bloch/
if [  ! -f rasqberry-bloch-isrunning ]; then
   nohup python3 -m http.server 8000 &
   echo $! > rasqberry-bloch-isrunning
   nohup chromium-browser --start-fullscreen --no-sandbox --enable-webgl --ignore-gpu-blacklist --test-type  http://127.0.0.1:8000 &
   echo $! >> rasqberry-bloch-isrunning
else
   kill `cat rasqberry-bloch-isrunning`
   rm rasqberry-bloch-isrunning
fi





killall python3 /usr/lib/chromium-browser/chromium-browser-v7 

