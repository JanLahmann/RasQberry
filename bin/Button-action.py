#!/usr/bin/env python3

# add to /etc/rc.local with
# /usr/bin/python3 /home/pi/.local/bin/Button-action.py
# Botton 1: GPIO Button 16 / LED 12, RasQ-LED clear / LED start
# Botton 2: GPIO Button 16 / LED 12, reboot / shutdown
# fyi: GPIO Button 24 / LED 23  works

from gpiozero import Button, LED
from signal import pause
from time import sleep
from subprocess import check_call,Popen
import os

button1 = Button(16, hold_time=2)
led1 = LED(12)

button2 = Button(24, hold_time=2)
led2 = LED(23)

def pressed1():
    led1.on()
    sleep(0.1)
    led1.off()
    sleep(0.1)
    led1.on()
    print("pressed1")
    os.system("touch /home/pi/pressed1")
    #check_call(['python3', '/home/pi/RasQberry/demos/bin/RasQ-LED.py'])
    Popen(["/usr/bin/python3", "/home/pi/.local/bin/rq_LED-off.py"])
    sleep(3)

def released1():
    led1.off()
    print("released1")
    os.system("touch /home/pi/released1")
    #check_call(['touch', '/home/pi/released1'])

def held1():
    led1.off()
    sleep(0.1)
    led1.on()
    sleep(0.1)
    led1.off()
    sleep(0.1)
    led1.on()
    sleep(0.1)
    led1.off()
    print("held1")
    os.system("touch /home/pi/held1")
    #check_call(['touch', '/home/pi/held1'])
    Popen(["/usr/bin/python3", "/home/pi/RasQberry/demos/bin/RasQ-LED.py"])


def pressed2():
    led2.on()
    sleep(0.1)
    led2.off()
    sleep(0.1)
    led2.on()
    print("pressed2")
    os.system("touch /home/pi/pressed2")
    #check_call(['touch', '/home/pi/pressed2'])

def released2():
    led2.off()
    print("released2")
    os.system("touch /home/pi/released2")
    #check_call(['touch', '/home/pi/released2'])
    os.system("/usr/sbin/reboot")

def held2():
    led2.off()
    sleep(0.1)
    led2.on()
    sleep(0.1)
    led2.off()
    sleep(0.1)
    led2.on()
    sleep(0.1)
    led2.off()
    print("held2")
    os.system("touch /home/pi/held2")
    #check_call(['touch', '/home/pi/held2'])
    os.system("/usr/sbin/shutdown")
    sleep(3)


button1.when_pressed = pressed1
button1.when_released = released1
button1.when_held = held1

button2.when_pressed = pressed2
button2.when_released = released2
button2.when_held = held2

pause()