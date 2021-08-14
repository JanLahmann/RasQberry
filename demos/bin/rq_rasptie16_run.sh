#!/bin/bash
#
echo; echo; echo "Raspberry-Tie 16 Qubit Demo"
#source ~/rasqberry/bin/activate
cd ~/quantum-raspberry-tie

nohup python3 QuantumRaspberryTie.qiskit.py $1 expt16.qasm & # 16 Qubit example
echo $! > raspberry-tie-isrunning
