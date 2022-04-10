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



from gpiozero import Button, LED
from signal import pause
from time import sleep
from subprocess import check_call
import os

button = Button(21, hold_time=2)
led = LED(20)

def say_hello():
    led.on()
    print("Hello!")
    os.system("touch /home/pi/say_hello")
    check_call(['touch', '/home/pi/say_hello2'])
    sleep(1)
    led.off()
    os.system("sleep 1")
    led.on()
    sleep(1)

def say_goodbye():
    led.off()
    print("Goodbye!")
    os.system("touch /home/pi/say_goodbye")

def shutdown():
    print("shutdown-held")
    os.system("touch /home/pi/shutdown")
    sleep(10)
    led.off()
    check_call(['touch', 'shutdown-held'])

button.when_pressed = say_hello
button.when_released = say_goodbye
button.when_held = shutdown

pause()