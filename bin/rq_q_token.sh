#!/bin/bash
#
source ~/rasqberry/bin/activate
echo; echo; echo "store IBM Q Experience access token"
(echo "from qiskit import IBMQ"; 
 echo "from getpass import getpass"; 
 echo "token = getpass('Enter your IBM Q Experience Token: ')"; 
 echo "print ('APItoken = \'' + str(token) + '\'')";
 echo "IBMQ.save_account(token)") | python > ~/.Qconfig_IBMQ_experience.py

[ -f ~/qrasp/Qconfig_IBMQ_experience.py ] && rq_qrasp_token.sh
