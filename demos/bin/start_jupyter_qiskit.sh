#!/bin/bash
#
# start jupyter notebooks with qiskit
# on port 8888 
#

cd ~
echo; echo  "default password for juopyter notebook is 'RasQberry'"; echo
nohup jupyter notebook qiskit-tutorials --port 8888 &
sleep 5