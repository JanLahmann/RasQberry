#!/bin/bash
#

. /home/pi/RasQberry/env-config.sh

echo; echo; echo "Qrasp"
#source ~/rasqberry/bin/activate
cd ~

if [ ! -d qrasp ]; then
  git clone https://github.com/JanLahmann/qrasp;
  /home/pi/RasQberry/demos/bin/rq_qrasp_token.sh
fi

cd qrasp 

if [  ! -f qrasp-isrunning ]; then
  [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Starting Qrasp Demo" 20 60 1
  nohup python3 qrasp.py &
  echo $! > qrasp-isrunning
else
   kill -15 `cat qrasp-isrunning`
   rm qrasp-isrunning
   /home/pi/.local/bin/clear_sense.py
fi
