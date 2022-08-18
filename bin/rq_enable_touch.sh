#!/bin/bash
#

. /home/pi/RasQberry/env-config.sh
update_environment_file () {
  sed -i "s/^$1=.*/$1=$2/gm" /home/pi/RasQberry/environment.env
  . /home/pi/RasQberry/env-config.sh
}

if [ "$IS_ENABLED_TOUCH4" = true ]; then
  return 0
else
  sudo cp /home/pi/.local/bin/rq_dispsetup.sh /usr/share/dispsetup.sh
  cd ~/
  [ -d Tools ] || mkdir Tools
  cd Tools
  [ -d LCD-show ] && ( echo "Automatic display configuration not possible" ) || ( git clone https://github.com/goodtft/LCD-show && update_environment_file "IS_ENABLED_TOUCH4" "true" && cd LCD-show/ && sudo ./MPI4008-show 180 )
fi