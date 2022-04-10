#!/usr/bin/env python3

# test with     python3 Button-test.py

from gpiozero import Button, LED
from signal import pause
from time import sleep
from subprocess import check_call

button = Button(21, hold_time=2)
led = LED(20)

def say_hello():
    led.on()
    print("Hello!")

def say_goodbye():
    led.off()
    print("Goodbye!")

def shutdown():
    print("shutdown-held")
    led.off()
    check_call(['touch', 'shutdown-held'])

button.when_pressed = say_hello
button.when_released = say_goodbye
button.when_held = shutdown

pause()

