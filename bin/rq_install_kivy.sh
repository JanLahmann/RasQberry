#!/bin/bash
#
# Install kivy
# and all needed packages for the kivy interface

pip3 install kivy
sudo apt-get install libsdl2-2.0-0 
sudo apt-get install libsdl2-image-2.0-0 
sudo apt-get install libsdl2-mixer-2.0-0 
sudo apt-get install libsdl2-ttf-2.0-0
pip3 install ewmh

echo "Installed Kivy"