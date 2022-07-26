#!/bin/bash
#

. /home/pi/RasQberry/env-config.sh

echo; echo; echo "Raspberry-Tie 5 Qubit Demo"
#source ~/rasqberry/bin/activate
cd ~

if [ ! -d quantum-raspberry-tie ]; then
  git clone https://github.com/JanLahmann/quantum-raspberry-tie;
fi

cd quantum-raspberry-tie

if [  ! -f raspberry-tie-isrunning ]; then
  [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Starting Rqapberry-Tie Demo ${1}" 20 60 1
  nohup python3 QuantumRaspberryTie.qiskit.py $1 & # standard 5 Qubit example
  echo $! > raspberry-tie-isrunning
  #python3 QuantumRaspberryTie.qiskit.py expt16.qasm # 16 Qubit example
  #/usr/bin/sense_emu_gui &
  #python3 QuantumRaspberryTie.qiskit.py -e  # "-e" forces to use the emulator
else
   kill -15 `cat raspberry-tie-isrunning`
   rm raspberry-tie-isrunning
   /home/pi/.local/bin/clear_sense.py
fi
