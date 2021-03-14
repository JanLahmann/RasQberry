#!/bin/bash
#
# installation of Qiskit 0.23
#

export STARTDATE=`date`
echo; echo; echo "Install Qiskit 0.23"; echo;
. /home/pi/.bashrc

pip3 install -U numpy Pillow
pip3 install --prefer-binary 'qiskit[visualization]==0.23.*'
pip3 list | grep qiskit

echo; echo "start Qiskit install: " $STARTDATE &&
echo "end   Qiskit install: " `date`