#!/usr/bin/env python3

# add to /etc/rc.local with
# /usr/bin/python3 /home/pi/.local/bin/Button-action.py
#  

from gpiozero import Button, LED
from signal import pause
#from time import sleep
#from subprocess import check_call
import os

button = Button(21, hold_time=2)
led = LED(20)

def say_hello():
    led.on()
    print("Hello!")
    os.system("touch /home/pi/say_hello")
    #check_call(['touch', '/home/pi/say_hello'])

def say_goodbye():
    led.off()
    print("Goodbye!")
    os.system("touch /home/pi/say_goodbye")
    #check_call(['touch', '/home/pi/say_goodbye'])

def shutdown():
    led.off()
    print("shutdown-held")
    os.system("touch /home/pi/shutdown")
    #check_call(['touch', '/home/pi/shutdown-held'])

button.when_pressed = say_hello
button.when_released = say_goodbye
button.when_held = shutdown

pause()