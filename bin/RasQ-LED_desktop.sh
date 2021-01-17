#!/bin/bash
#
echo; echo; echo "start RasQ-LED demo"

source ~/rasqberry/bin/activate
cd ~

python /home/pi/.local/bin/RasQ-LED.py

sleep 2
