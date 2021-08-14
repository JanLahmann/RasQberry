#!/bin/bash
#
echo; echo; echo "rq_sense_menu_run.sh"
cd /home/pi/.local/bin

#nohup sh -c 'sleep 5 && python3 rq_sense_menu.py' &
sleep 5
python3 rq_sense_menu.py &