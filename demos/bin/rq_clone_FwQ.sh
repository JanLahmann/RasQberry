#!/bin/bash
#
# clone the Fun-with-Quantum Repository

cd ~/
git clone https://github.com/JanLahmann/Fun-with-Quantum.git
#pip3 install --prefer-binary cvxpy
export PATH=/home/pi/.local/bin:/home/pi/RasQberry/demos/bin:$PATH
jupyter notebook Fun-with-Quantum $1 $2 $3