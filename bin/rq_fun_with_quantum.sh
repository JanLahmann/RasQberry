#!/bin/bash
#
# Open Fun-with-Quantum Repo on GitHub

[ -f /home/pi/nohup.out ] && rm -f /home/pi/nohup.out
setsid nohup chromium-browser --start-fullscreen --enable-webgl --ignore-gpu-blacklist https://github.com/JanLahmann/Fun-with-Quantum#fun-with-quantum &&
sleep 6

