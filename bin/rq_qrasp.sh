#!/bin/bash
#
echo; echo; echo "Qrasp"
source ~/rasqberry/bin/activate
cd ~

if [ ! -d qrasp ]; then
  git clone https://github.com/ordmoj/qrasp;
  /home/pi/.local/bin/rq_qrasp_token.sh
fi

cd qrasp 

if [  ! -f qrasp-isrunning ]; then
  [ ! -f /home/pi/.rq_no_messages ] && whiptail --msgbox "Starting Qrasp Demo" 20 60 1
  cd ~/qrasp
  nohup python main_controller.py &
  echo $! > qrasp-isrunning
else
   kill -15 `cat qrasp-isrunning`
   rm qrasp-isrunning
   /home/pi/RasQberry/bin/clear_sense.py
fi
