#!/usr/bin/env python3

# add to /etc/rc.local with
# /usr/bin/python3 /home/pi/.local/bin/Button-action.py
#  

from gpiozero import Button
import os

Button(21).wait_for_press()
os.system("touch /home/pi/buttonpressed-rclocal")
os.system("sleep 1")
#os.system("sudo poweroff")
