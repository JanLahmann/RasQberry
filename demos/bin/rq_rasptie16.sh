#!/bin/bash
#

. /home/pi/RasQberry/env-config.sh

echo; echo; echo "Raspberry-Tie 16 Qubit Demo"
#source ~/rasqberry/bin/activate
cd ~

if [ ! -d quantum-raspberry-tie ]; then
  git clone https://github.com/JanLahmann/quantum-raspberry-tie;
fi

cd quantum-raspberry-tie

if [  ! -f raspberry-tie-isrunning ]; then
  [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Starting Rqapberry-Tie Demo ${1}" 20 60 1
  nohup python3 QuantumRaspberryTie.qiskit.py $1 expt16.qasm & # 16 Qubit example
  echo $! > raspberry-tie-isrunning
else
   kill -15 `cat raspberry-tie-isrunning`
   rm raspberry-tie-isrunning
   /home/pi/.local/bin/clear_sense.py
fi