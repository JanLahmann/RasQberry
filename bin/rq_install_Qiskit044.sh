#!/bin/bash
#
# installation of Qiskit 0.44
#

# Load environment variables
. /home/pi/RasQberry/env-config.sh

export STARTDATE=`date`
echo; echo; echo "Install Qiskit 0.44"; echo;

if [ "$OS_VERSION" == "bookworm" ]; then
  echo "bookworm 64-bit OS detected. Installing Qiskit 1.0"
  pip install --prefer-binary --break-system-packages 'qiskit[all]==1.0.*'
  exit
fi

# install current version of rust; needed for retworkx
curl -o get_rustup.sh -s https://sh.rustup.rs
sh ./get_rustup.sh -y
source $HOME/.cargo/env

#pip3 install --prefer-binary cmake "pillow>=6.2.0" "decorator<5,>=4.3" "numpy<1.23.0,>=1.21.0" 
pip3 install --no-warn-script-location --prefer-binary 'qiskit[visualization,all]==0.44' --no-binary=qiskit-terra,rustworkx
pip3 install ~/RasQberry/whl/ibm_quantum_widgets-1.0.3-py2.py3-none-any.whl
pip3 install ~/RasQberry/whl/qiskit_aer-0.12.2-cp39-cp39-linux_armv7l.whl
pip3 install qiskit-ibmq-provider

pip3 list | grep qiskit

echo; echo "start Qiskit install: " $STARTDATE &&
echo "end   Qiskit install: " `date`