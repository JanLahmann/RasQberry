#!/bin/bash
#
# install Qiskit tutorials
echo; echo; echo "install Qiskit tutorials"
#source ~/rasqberry/bin/activate
cd ~/
git clone https://github.com/Qiskit/qiskit-tutorials
pip3 install --prefer-binary cvxpy
export PATH=/home/pi/.local/bin:/home/pi/RasQberry/demos/bin:$PATH
jupyter notebook qiskit-tutorials $1 $2 $3
