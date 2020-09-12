#!/bin/bash
#
echo; echo; echo "Bloch Sphere Demo"
cd ~

if [ ! -d rasqberry-grok-bloch ]; then
   git clone https://github.com/JanLahmann/rasqberry-grok-bloch;
fi


cd rasqberry-grok-bloch/
export DISPLAY=:0

python3 -m http.server 8000 &

chromium-browser --start-fullscreen --no-sandbox --enable-webgl --ignore-gpu-blacklist  http://127.0.0.1:8000 &


