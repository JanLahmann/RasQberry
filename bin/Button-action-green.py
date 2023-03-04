#!/usr/bin/env python3

# add to /etc/rc.local with
# /usr/bin/python3 /home/pi/.local/bin/Button-action-green.py
# Button 1 (blue): GPIO Button 16 / LED 12, RasQ-LED clear / LED start
# Button 2 (green): GPIO Button 24 / LED 23 

# pressed / held logic can be improved according to https://gpiozero.readthedocs.io/en/stable/faq.html#how-do-i-use-button-when-pressed-and-button-when-held-together


# better for shutdown/reboot: https://gist.github.com/lbussy/9e81cbcc617952f1250e353bd42e7775
# Add the following three lines to your /boot/config.txt:
# enable shutdown/reboot on GPIO 3; and LED power indicator on GPIO 4
# dtoverlay=gpio-shutdown,gpio_pin=3
# gpio=4=op,dh


from gpiozero import Button, LED
from signal import pause
from time import sleep
from subprocess import Popen
#import os

Button.was_held = False

button = Button(24, hold_time=2)
led = LED(23)


def pressed():
    for x in range(2):
      led.off()
      sleep(0.2)
      led.on()
      sleep(0.2)
    #print("pressed")
    #os.system("touch /home/pi/pressed")
    Popen(["/usr/bin/python3", "/home/pi/.local/bin/rq_LED-off.py"])

def released(btn):
    if not btn.was_held:
        pressed()
    btn.was_held = False
    led.off()
    #print("released")
    #os.system("touch /home/pi/released")

def held(btn):
    btn.was_held = True
    for x in range(5):
      led.off()
      sleep(0.1)
      led.on()
      sleep(0.1)
    #print("held")
    #os.system("touch /home/pi/held")
    Popen(["/usr/bin/sudo", "-u", "pi", "-H", "/usr/bin/python3", "/home/pi/RasQberry/demos/bin/RasQ-LED.py"])


#button.when_pressed = pressed
button.when_held = held
button.when_released = released

pause()