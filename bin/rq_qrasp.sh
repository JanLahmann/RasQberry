#!/bin/bash
#
echo; echo; echo "Qrasp"
cd ~
git clone https://github.com/ordmoj/qrasp
cd ~/qrasp
echo; echo; echo "set IBM Q Experience token"
( echo "from getpass import getpass"; 
  echo "token = getpass('IBM Q Experience Token: ')";
  echo "print ('APItoken = \'' + str(token) + '\'')" 
 ) | python > Qconfig_IBMQ_experience.py
#python main_controller.py
