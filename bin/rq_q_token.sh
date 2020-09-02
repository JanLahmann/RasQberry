#!/bin/bash
#
rasqberry
cho; echo; echo "store IBM Q Experience access token"
(echo "from qiskit import IBMQ"; 
 echo "from getpass import getpass"; 
 echo "token = getpass('IBM Q Experience Token: ')"; 
 echo "IBMQ.save_account(token)") | python
