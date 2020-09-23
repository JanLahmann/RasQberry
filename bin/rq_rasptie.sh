#!/bin/bash
#
echo; echo; echo "Raspberry-Tie 5 Qubit Demo"
source ~/rasqberry/bin/activate
cd ~

if [ ! -d quantum-raspberry-tie ]; then
  git clone https://github.com/KPRoche/quantum-raspberry-tie;
fi

cd quantum-raspberry-tie

if [  ! -f raspberry-tie-isrunning ]; then
  [ ! -f /home/pi/.rq_no_messages ] && whiptail --msgbox "Starting Rqapberry-Tie Demo" 20 60 1
  nohup python QuantumRaspberryTie.qiskit.py & # standard 5 Qubit example
  echo $! > raspberry-tie-isrunning
  #python QuantumRaspberryTie.qiskit.py expt16.qasm # 16 Qubit example
  #/usr/bin/sense_emu_gui &
  #python QuantumRaspberryTie.qiskit.py -e  # "-e" forces to use the emulator
else
   kill -15 `cat raspberry-tie-isrunning`
   rm raspberry-tie-isrunning
   /home/pi/rasqberry/bin/clear_sense.py
fi
