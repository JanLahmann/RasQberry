#!/usr/bin/env python3
# 
#

# test with     python3 Button-LED-test.py

import RPi.GPIO as GPIO
from time import sleep

LED_PIN = 20

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(LED_PIN,GPIO.OUT)
print ("LED on")
GPIO.output(LED_PIN,GPIO.HIGH)
sleep(2)
print ("LED off")
GPIO.output(20,GPIO.LOW)
