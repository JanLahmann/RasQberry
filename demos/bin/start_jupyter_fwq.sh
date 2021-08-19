#!/bin/bash
#
# start jupyter notebooks with Fun-with-Quantum
# on port 8889
#

cd ~

nohup jupyter notebook Fun-with-Quantum -port 8889 &
sleep 5