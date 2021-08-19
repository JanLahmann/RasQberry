#!/bin/bash
#
# start jupyter notebooks with qiskit
# on port 8888 
#

nohup jupyter notebook qiskit-tutorials -port 8888 &
#sudo -u pi -i nohup /home/pi/RasQberry/demos/bin/rq_qiskit_tutorial.sh -port 8888 &