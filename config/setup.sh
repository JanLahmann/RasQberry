#!/bin/sh

do_rq_initial_config() {
  # set PATH
  ( echo; echo '##### added for rasqberry #####';
  echo 'export PATH=/home/pi/.local/bin:/home/pi/RasQberry/demos/bin:$PATH';
  ) >> /home/pi/.bashrc && . /home/pi/.bashrc
  # install bluetooth manager blueman
  apt -y install blueman
  # install emojis for Qoffee-Maker demo
  apt -y install fonts-noto-color-emoji
  # install python package dotenv
  pip install python-dotenv
  # fix locale
  echo "LANG=en_GB.UTF-8\nLC_CTYPE=en_GB.UTF-8\nLC_MESSAGES=en_GB.UTF-8\nLC_ALL=en_GB.UTF-8" > /etc/default/locale
  if [ "$INTERACTIVE" = True ]; then
      [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "initial config completed" 20 60 1
  fi
}

do_rasqberry_update() {
  sed -i 's/CONF_SWAPSIZE=100/CONF_SWAPSIZE=1024/' /etc/dphys-swapfile
  /etc/init.d/dphys-swapfile stop
  /etc/init.d/dphys-swapfile start
  apt update
  apt -y full-upgrade
  #reboot
  if [ "$INTERACTIVE" = True ]; then
    [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Please exit and reboot" 20 60 1
  fi
  ASK_TO_REBOOT=1
}

do_rasqberry_install_libcint() {
  echo; echo "Install libcint"; echo;
  cd /home/pi/
  apt -y install cmake libatlas-base-dev p7zip-full rustc cargo
  if [ ! -f /usr/local/lib/libcint.so ]; then
    sudo -u pi -H -- sh -c 'git clone https://github.com/sunqm/libcint.git &&
      mkdir -p libcint/build && cd libcint/build &&
      cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/ .. '
    cd /home/pi/libcint/build && make install && cd /home/pi/
  fi
  #whiptail --msgbox "libcint is installed" 20 60 1
}

do_rasqberry_install_general() {
    echo; echo "Install Qiskit $1"; echo;
    #check if version equals 019 or 020
    if [ "$1" = "019" ] || [ "$1" = "020" ]; then
      do_rasqberry_install_libcint;
    else
      apt -y install libatlas-base-dev
    fi
    sudo -u pi -H -- sh -c "/home/pi/.local/bin/rq_install_Qiskit$1.sh"
    if [ "$INTERACTIVE" = True ]; then
      [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Qiskit $1 installed" 20 60 1
    fi
  }

do_install_kivy() {
  sudo -u pi -H -- sh -c /home/pi/RasQberry/bin/rq_install_kivy.sh
}

do_rasqberry_config_demos(){
  sudo -u pi -H -- sh -c /home/pi/RasQberry/demos/bin/rq_q_token.sh
  sudo -u pi -i /home/pi/.local/bin/rq_jupyter_conf.sh
  # clone Git-Repositories
  sudo -u pi -i /home/pi/RasQberry/demos/bin/rq_clone_repos.sh
  # install kivy
  do_install_kivy
  # enable jupyter notebook autostart
  if [ "$INTERACTIVE" = True ]; then
    [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "enabled jupyter notebook autostart on port 8888 and 8889" 20 60 1
  fi
  echo "@/home/pi/RasQberry/demos/bin/start_jupyter_notebooks.sh" >> /etc/xdg/lxsession/LXDE-pi/autostart
}

do_rq_enable_docker() {
  curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
  apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io
  usermod -aG docker pi
  systemctl enable docker
  if [ "$INTERACTIVE" = True ]; then
      [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "docker installed and enabled" 20 60 1
      [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Please exit and reboot" 20 60 1
  fi
  ASK_TO_REBOOT=1
}

do_rq_configure_button() {
  # add Button-action.py to /etc/rc.local
  # enable reboot overlay in /boot/config.txt
  if [ "$BUTTON_CONFIGURED" = false ]; then
    sed -i 's/exit 0//' /etc/rc.local
    echo "/usr/bin/python3 /home/pi/.local/bin/Button-action.py\n\nexit 0" >> /etc/rc.local
    echo "\n# enable shutdown/reboot on GPIO 3; and LED power indicator on GPIO 4\ndtoverlay=gpio-shutdown,gpio_pin=3\ngpio=4=op,dh" >> /boot/config.txt
    update_environment_file "BUTTON_CONFIGURED" "true"
  fi

  if [ "$INTERACTIVE" = True ]; then
      [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Button configured" 20 60 1
  fi
}

do_rasqberry_qtoken_update(){
  sudo -u pi -H -- sh -c /home/pi/RasQberry/demos/bin/rq_q_token.sh
}

do_rq_setup_SenseHAT(){
  cd ~

  # disable messages
  update_environment_file "RQ_NO_MESSAGES" "true"

  # Additional SenseHAT libraries (not sure if they are needed)
  # apt -y install python3-sense-emu sense-emu-tools
  # sudo -u pi -H -- sh -c /home/pi/.local/bin/rq_sensehat.sh

  # input IBM Quantum Token
  do_rasqberry_qtoken_update

  # install/clone qrasp
  sudo -u pi -H -- sh -c /home/pi/RasQberry/demos/bin/rq_qrasp_install.sh

  # configure qrasp autostart in crontab
  #(crontab -l 2>/dev/null; echo "@reboot sudo -u pi -H -- sh -c /home/pi/qrasp/qrasp.sh > /home/pi/qrasp/qrasp.sh.log 2>&1") | crontab -
  (crontab -l 2>/dev/null; echo "@reboot sudo -u pi -H --  python3 /home/pi/.local/bin/rq_sense_menu.py > /home/pi/RasQberry/rq_sense_menu.py.log 2>&1") | crontab -

  # install/clone raspberry-tie
  sudo -u pi -H -- sh -c /home/pi/RasQberry/demos/bin/rq_rasptie_install.sh

  # reboot to activate crontab entry for sense_menu
  if [ "$INTERACTIVE" = True ]; then
    [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Please exit and reboot" 20 60 1
  fi
  ASK_TO_REBOOT=1
}