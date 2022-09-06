#!/bin/sh

#Demos

do_rasqberry_run_bloch(){
  if [ "$INTERACTIVE" = True ]; then
    [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "starting run_bloch" 20 60 1
  fi
  # check if GL2/GL3 driver is enabled
  rq_check_gldriver

  # enable autostart ?
  do_rasqberry_activate_bloch_autostart

  # run the bloch demo
  sudo -u pi -H -- sh -c /home/pi/RasQberry/demos/bin/rq_bloch.sh
}

do_rasqberry_run_fractals(){
  do_rasqberry_install_general 037
  pip install -U numpy
  pip install celluloid
  pip install selenium
  pip install --upgrade --force-reinstall chromedriver-binary-auto
  pip install ipython
  sudo -u pi -H -- sh -c '/usr/bin/python3 /home/pi/RasQberry/demos/bin/fractal_files/fractals.py'
}

do_RasQ_LED(){
  sudo -u pi -H -- sh -c '/usr/bin/python3 /home/pi/RasQberry/demos/bin/RasQ-LED.py'
}

do_led_lights_off(){
  sudo -H -- sh -c /home/pi/.local/bin/rq_LED-off.py
}

do_rasqberry_run_rasptie_no_network(){
  sudo -u pi -H -- sh -c "/home/pi/RasQberry/demos/bin/rq_rasptie.sh -local"
}

do_rasqberry_run_rasptie16_no_network(){
  sudo -u pi -H -- sh -c "/home/pi/RasQberry/demos/bin/rq_rasptie16.sh -local"
}

do_rasqberry_run_qrasp(){
  sudo -u pi -H -- sh -c /home/pi/RasQberry/demos/bin/rq_qrasp.sh
}

do_sensehat_display_off(){
  sudo -H -- sh -c /home/pi/.local/bin/clear_sense.py
}

#HD Demos
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