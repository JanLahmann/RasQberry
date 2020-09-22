#!/bin/bash
#
echo; echo; echo "Raspberry-Tie 16 Qubit Demo"
cd ~

if [ ! -d quantum-raspberry-tie ]; then
   git clone https://github.com/KPRoche/quantum-raspberry-tie;
fi

cd quantum-raspberry-tie

source ~/rasqberry/bin/activate

if [  ! -f raspberry-tie-isrunning ]; then
  nohup python QuantumRaspberryTie.qiskit.py expt16.qasm & # 16 Qubit example
  echo $! > raspberry-tie-isrunning
else
   kill -15 `cat raspberry-tie-isrunning`
   rm raspberry-tie-isrunning
   /home/pi/rasqberry/bin/clear_sense.py
fi