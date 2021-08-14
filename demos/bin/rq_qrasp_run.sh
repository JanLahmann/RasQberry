#!/bin/bash
#
echo; echo; echo "Qrasp"
#source ~/rasqberry/bin/activate
cd ~/qrasp 

nohup python3 qrasp.py &
echo $! > qrasp-isrunning

