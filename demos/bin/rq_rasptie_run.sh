#!/bin/bash
#
echo; echo; echo "Raspberry-Tie 5 Qubit Demo"
cd ~/quantum-raspberry-tie

#nohup sh -c 'sleep 5 && python3 QuantumRaspberryTie.qiskit.py $1 -local' &
sleep 2
python3 QuantumRaspberryTie.qiskit.py $1 &
