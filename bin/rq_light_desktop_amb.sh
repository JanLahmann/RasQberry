#!/bin/bash
#
echo "Toggle Cryostat Light Ring Ambilight"

cd ~

# turn on or off the LED light ring above the cryostat
if [ -f /home/pi/RasQberry/.is_running_LED ]; then
  echo "Stopping Cryostat Ambilight..."
  sudo kill -15 `cat /home/pi/RasQberry/.is_running_LED`
  rm -f /home/pi/RasQberry/.is_running_LED
  python3 /home/pi/.local/bin/rq_LED-off.py -c
else
  echo "Starting Cryostat Ambilight..."
  nohup python3 /home/pi/.local/bin/rq_LED-Amb.py -c > /dev/null 2>/dev/null &
  echo $! > /home/pi/RasQberry/.is_running_LED
fi

sleep 3