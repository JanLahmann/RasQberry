#!/bin/bash
#
echo; echo; echo "Raspberry-Tie 5 Qubit Demo"
#source ~/rasqberry/bin/activate
cd ~/quantum-raspberry-tie

nohup python3 QuantumRaspberryTie.qiskit.py $1 & # standard 5 Qubit example
echo $! > raspberry-tie-isrunning
