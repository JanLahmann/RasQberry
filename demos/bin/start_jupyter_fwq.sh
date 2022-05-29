#!/bin/bash
#
# start jupyter notebooks with Fun-with-Quantum
# on port 8889
#

cd ~
echo; echo  "default password for jupyter notebook is 'RasQberry'"; echo
nohup jupyter notebook Fun-with-Quantum --port 8889 &
sleep 5