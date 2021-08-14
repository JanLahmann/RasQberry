#!/bin/bash
#
echo; echo; echo "Qrasp"
#source ~/rasqberry/bin/activate
cd ~/qrasp 

nohup sh -c 'sleep 5 && python3 qrasp.py' &
