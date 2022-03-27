#!/bin/bash
#
echo; echo; echo "Bloch Sphere Demo"

cd ~

# check if Bloch demo is installed
if [ ! -d rasqberry-grok-bloch ]; then
   git clone https://github.com/JanLahmann/rasqberry-grok-bloch;
   whiptail --msgbox "Bloch demo code downloaded." 20 60 1
fi


cd rasqberry-grok-bloch/
if [ -f rasqberry-bloch-isrunning ]; then
   kill -15 `cat rasqberry-bloch-isrunning`
   rm rasqberry-bloch-isrunning
fi

nohup python3 -m http.server 8000 &
echo $! > rasqberry-bloch-isrunning
#nohup chromium-browser --start-fullscreen --no-sandbox --enable-webgl --ignore-gpu-blacklist --test-type  http://127.0.0.1:8000 &
#setsid nohup chromium-browser --start-fullscreen --enable-webgl --ignore-gpu-blacklist  http://127.0.0.1:8000 &
setsid nohup chromium-browser --enable-webgl --ignore-gpu-blacklist  http://127.0.0.1:8000 &
echo $! >> rasqberry-bloch-isrunning
sleep 6
#whiptail --msgbox "Please wait until BlochSphere Demo has started" 20 60 1
