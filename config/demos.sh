#!/bin/sh

# Demos, more info https://janlahmann.github.io/RasQberry/documentation/RasQberry_Demos.html

# Run the bloch sphere demo (on 4 inch screen)
do_rasqberry_run_bloch(){
  if [ "$INTERACTIVE" = true ]; then
    [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "starting run_bloch" 20 60 1
  fi
  # check if GL2/GL3 driver is enabled
  rq_check_gldriver

  # enable autostart ?
  do_rasqberry_activate_bloch_autostart

  # run the bloch demo
  sudo -u pi -H -- sh -c /home/pi/RasQberry/demos/bin/rq_bloch.sh
}

# Run the fractal demo in browser
do_rasqberry_run_fractals(){
  # check if Initial Setup is done
  if [ "$REQUIREMENTS_INSTALLED" = false ]; then
    do_rasqberry_install_requirements
  fi
  sudo apt-get install chromium-chromedriver
  cd /home/pi/RasQberry/demos/bin/fractal_files || exit
  sudo -u pi -H -- sh -c '/usr/bin/python3 /home/pi/RasQberry/demos/bin/fractal_files/fractals.py'
  cd || exit
}

# Run the RasQ-LED demo for a LED Ring connected to RasQberry
do_RasQ_LED(){
  sudo -u pi -H -- sh -c '/usr/bin/python3 /home/pi/RasQberry/demos/bin/RasQ-LED.py'
}

do_led_lights_off(){
  sudo -H -- sh -c /home/pi/.local/bin/rq_LED-off.py
}

# Run the Raspberry-Tie demo (5 & 16 Qubits)
do_rasqberry_run_rasptie_no_network(){
  sudo -u pi -H -- sh -c "/home/pi/RasQberry/demos/bin/rq_rasptie.sh -local"
}

do_rasqberry_run_rasptie16_no_network(){
  sudo -u pi -H -- sh -c "/home/pi/RasQberry/demos/bin/rq_rasptie16.sh -local"
}

# Run the Qrasp demo
do_rasqberry_run_qrasp(){
  sudo -u pi -H -- sh -c /home/pi/RasQberry/demos/bin/rq_qrasp.sh
}

# turn off the sense hat; used by Qrasp and Raspberry-Tie
do_sensehat_display_off(){
  sudo -H -- sh -c /home/pi/.local/bin/clear_sense.py
}

# HD Demos

# Start th jupyter notebook server for the Qiskit tutorials
do_clone_qiskit_start_jupyter() {
  if [ "$INTERACTIVE" = true ]; then
    [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Starting jupyter notebook server..." 20 60 1
  fi
  sudo -u pi -i nohup /home/pi/RasQberry/demos/bin/rq_clone_qiskit_tutorial.sh --port 8888 &
}

# Start the jupyter notebook server for the Fun-with-quantum repository
do_clone_fwq_start_jupyter() {
  if [ "$INTERACTIVE" = true ]; then
    [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Starting jupyter notebook server..." 20 60 1
  fi
  sudo -u pi -i nohup /home/pi/RasQberry/demos/bin/rq_clone_FwQ.sh --port 8889 &
}
