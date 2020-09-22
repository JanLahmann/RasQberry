#!/bin/bash
#
echo; echo; echo "Qrasp"
source ~/rasqberry/bin/activate
cd ~

if [ ! -d qrasp ]; then
  git clone https://github.com/ordmoj/qrasp;

  cd ~/qrasp
  echo; echo; echo "set IBM Q Experience token"
  ( echo "from getpass import getpass"; 
    echo "token = getpass('Enter your IBM Q Experience Token: ')";
    echo "print ('APItoken = \'' + str(token) + '\'')" 
  ) | python > Qconfig_IBMQ_experience.py
fi

if [  ! -f qrasp-isrunning ]; then
  whiptail --msgbox "Starting Qrasp Demo" 20 60 1
  cd ~/qrasp
  python main_controller.py
  echo $! > qrasp-isrunning
else
   kill -15 `cat qrasp-isrunning`
   rm qrasp-isrunning
   /home/pi/rasqberry/bin/clear_sense.py
fi
