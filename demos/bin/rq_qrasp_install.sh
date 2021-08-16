#!/bin/bash
#
echo; echo; echo "Qrasp"
#source ~/rasqberry/bin/activate
cd ~

if [ ! -d qrasp ]; then
  git clone https://github.com/JanLahmann/qrasp;
  /home/pi/RasQberry/demos/bin/rq_qrasp_token.sh
fi

