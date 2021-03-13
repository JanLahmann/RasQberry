#!/bin/bash
#
# installation of Qiskit 0.20
#

eexport STARTDATE=`date`
# 1. Setup virtualenv "rasqberry"
#echo; echo; echo "Setup virtualenv rasqberry"; echo;
( echo; echo '##### added for rasqberry #####';
echo 'export PATH=/home/pi/.local/bin:$PATH';
#echo "alias rasqberry='source ~/rasqberry/bin/activate'";
) >> ~/.bashrc && . ~/.bashrc

#pip3 install --upgrade pip
#python3 -m pip install virtualenv
#python3 -m virtualenv rasqberry
#source ~/rasqberry/bin/activate

# 2. Install qiskit

echo; echo; echo "Install Qiskit"; echo;
pip3 install --prefer-binary 'qiskit[visualization]==0.20.*'
pip3 list | grep qiskit

echo; echo "start Qiskit install: " $STARTDATE &&
echo "end   Qiskit install: " `date`
