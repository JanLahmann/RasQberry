#!/bin/sh

do_clone_qiskit_start_jupyter() {
  if [ "$INTERACTIVE" = True ]; then
    [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Starting jupyter notebook server..." 20 60 1
  fi
  sudo -u pi -i nohup /home/pi/RasQberry/demos/bin/rq_clone_qiskit_tutorial.sh --port 8888 &
}

do_clone_fwq_start_jupyter() {
  if [ "$INTERACTIVE" = True ]; then
    [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Starting jupyter notebook server..." 20 60 1
  fi
  sudo -u pi -i nohup /home/pi/RasQberry/demos/bin/rq_clone_FwQ.sh --port 8889 &
}