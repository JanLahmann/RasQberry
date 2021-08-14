# Main controller for Qiskit on Raspberry PI SenseHat.

# Import required modules.
from sense_hat import SenseHat, ACTION_PRESSED, ACTION_HELD
hat = SenseHat()
# Set default SenseHat configuration.
hat.clear()
hat.low_light = True

from time import sleep
import os, atexit, signal


# Understand which direction is down, and rotate the SenseHat display accordingly.
def set_display():
        acceleration = hat.get_accelerometer_raw()
        x = acceleration['x']
        y = acceleration['y']
        z = acceleration['z']
        x=round(x,0)
        y=round(y,0)
        z=round(z,0)
        if x == 1:
            hat.set_rotation(270)
        else:
            if x == -1:
                hat.set_rotation(90)
            else:
                if y == 1:
                    hat.set_rotation(0)
                else:
                    hat.set_rotation(180)

set_display()       



# display pics/logos on the SenseHAT
def show_pic(name, pic):
    print(name)
    hat.set_pixels(pic)
    sleep(1)

# Background icons
X = [255, 0, 255]  # Magenta
Y = [255,192,203] # Pink
P = [255,255,0] #Yellow
O = [0, 0, 0]  # Black
B = [0,0,255] # Blue
#B = [70,107,176] # IBM Blue
W = [255, 255, 255] #White

super_position = [
O, O, O, Y, X, O, O, O,
O, O, Y, X, X, Y, O, O,
O, Y, O, O, X, O, Y, O,
O, Y, O, O, X, O, Y, O,
O, Y, O, O, X, O, Y, O,
O, Y, O, O, X, O, Y, O,
O, O, Y, O, X, Y, O, O,
O, O, O, X, X, X, O, O
]
show_pic("super_position", super_position)


IBM_Q = [
B, B, B, W, W, B, B, B,
B, B, W, B, B, W, B, B,
B, W, B, B, B, B, W, B,
P, P, P, B, B, B, W, B,
B, W, P, B, B, B, W, B,
P, P, P, B, B, W, B, B,
P, B, B, W, W, B, B, B,
P, P, P, W, W, W, B, B
]
show_pic("IBM_Q", IBM_Q)

hat.show_message("up: qrasp")
hat.show_message("left/right: raspberry-tie")
hat.show_message("down: shutdown")


# The main loop.
# Use the joystick to select and execute one of the Qiskit function files.
# see examples in https://pythonhosted.org/sense-hat/api/

def call_qrasp():
    os.system("/home/pi/RasQberry/demos/bin/rq_qrasp_run.sh")

def call_tie5():
    os.system("/home/pi/RasQberry/demos/bin/rq_rasptie_run.sh -local")

def call_tie16():
    os.system("/home/pi/RasQberry/demos/bin/rq_rasptie16_run.sh -local")

def pushed_up(event):
    if event.action == ACTION_PRESSED:
        atexit.register(call_qrasp)
        os.kill(os.getpid(), signal.SIGINT)

def pushed_left(event):
    if event.action == ACTION_PRESSED:
        atexit.register(call_tie5)
        os.kill(os.getpid(), signal.SIGINT)
      
def pushed_right(event):
    if event.action == ACTION_PRESSED:
        atexit.register(call_tie16)
        os.kill(os.getpid(), signal.SIGINT)

def pushed_down(event):
    global hat
    if event.action == ACTION_PRESSED:
        hat.show_message("Shutdown...")
        hat.clear()
        os.system('sudo halt')

def pushed_middle(event):
    global hat
    if event.action == ACTION_PRESSED:
        hat.show_message("middle?")
    

from signal import pause
hat.stick.get_events() # empty the event buffer
print("starting main loop")
hat.stick.direction_up = pushed_up
hat.stick.direction_down = pushed_down
hat.stick.direction_left = pushed_left
hat.stick.direction_right = pushed_right
hat.stick.direction_middle = pushed_middle
pause()
