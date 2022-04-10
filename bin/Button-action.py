#!/usr/bin/env python3

# add to /etc/rc.local with
# /usr/bin/python3 /home/pi/.local/bin/Button-action.py
#  

from gpiozero import Button, LED
from signal import pause
#from time import sleep
#from subprocess import check_call
import os

button1 = Button(21, hold_time=2)
led1 = LED(20)

def pressed1(led):
    led.on()
    print("pressed1")
    os.system("touch /home/pi/pressed1")
    #check_call(['touch', '/home/pi/pressed1'])

def released1(led):
    led.off()
    print("released1")
    os.system("touch /home/pi/released1")
    #check_call(['touch', '/home/pi/released1'])

def held1(led):
    led.off()
    sleep(0.1)
    led.on()
    sleep(0.1)
    led.off()
    sleep(0.1)
    led.on()
    sleep(0.1)
    led.off()
    print("held1")
    os.system("touch /home/pi/held1")
    #check_call(['touch', '/home/pi/held1'])

button1.when_pressed = pressed1(led1)
button1.when_released = released1(led1)
button1.when_held = held1(led1)

pause()