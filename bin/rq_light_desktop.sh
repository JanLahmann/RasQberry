#!/bin/bash
#
echo; echo; echo "Toggle Light"

cd ~

# turn on or off the LED light ring above the cryostat
if [ -f /home/pi/RasQberry/.is_running_LED ]; then
  kill -15 `cat /home/pi/RasQberry/.is_running_LED`
  rm /home/pi/RasQberry/.is_running_LED
  python3 .local/bin/rq_LED-off.py -c
else
  nohup python3 .local/bin/rq_LED-test.py -c &
  echo $! > /home/pi/RasQberry/.is_running_LED
fi

sleep 2
