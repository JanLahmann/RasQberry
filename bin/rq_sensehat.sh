#!/bin/bash
#
# Sense HAT
echo; echo; echo "Sense HAT"
cd ~
pip install sense-hat RTIMULib
git clone https://github.com/astro-pi/python-sense-hat
#cd python-sense-hat/examples/
#./rainbow.py
echo "alias sense_clear='(echo \"from sense_hat import SenseHat\"; echo \"SenseHat().clear()\") | python' ">> ~/.bashrc && . ~/.bashrc

# Sense HAT + Emulator
echo; echo; echo "Sense HAT Emulator"
pip install sense_emu
echo "alias sense_emu_gui=/usr/bin/sense_emu_gui" >> ~/.bashrc
. ~/.bashrc
