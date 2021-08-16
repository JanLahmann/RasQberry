#!/bin/bash
#
echo; echo; echo "Raspberry-Tie 5 Qubit Demo"
#source ~/rasqberry/bin/activate
cd ~

if [ ! -d quantum-raspberry-tie ]; then
  git clone https://github.com/JanLahmann/quantum-raspberry-tie;
fi
