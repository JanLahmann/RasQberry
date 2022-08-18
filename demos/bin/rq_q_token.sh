#!/bin/bash
#
#source ~/rasqberry/bin/activate

[ -f ~/.qiskit/qiskitrc ] && rm ~/.qiskit/qiskitrc

echo; echo; echo "store IBM Q Experience access token";
echo "Get access to your IBM Q Experience token as decribed here:";
echo "https://quantum-computing.ibm.com/docs/manage/account/";
echo "Please wait for the prompt to enter your token";

token=$( (echo "from qiskit import IBMQ";
 echo "from getpass import getpass"; 
 echo "token = getpass('Enter your IBM Q Experience Token: ')"; 
 echo "print ('IBM_Q_API_TOKEN=\"' + str(token) + '\"')";
 echo "IBMQ.save_account(token)") | python3 )

sed -i "s/IBM_Q_API_TOKEN=.*/$token/gm" /home/pi/RasQberry/rasqberry_environment.env
