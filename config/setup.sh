#!/bin/sh

############# CONFIGURATION METHODS #############

# Initial

# Function to update values stored in the rasqberry_environment.env file
update_environment_file () {
  #check whether string is empty
  if [ -z "$2" ]||[ -z "$1" ]; then
    # whiptail message box to show error
    whiptail --title "Error" --msgbox "Error: No value provided. Environment variable not updated" 8 78
  else
    # update environment file
    sed -i "s/^$1=.*/$1=$2/gm" /home/pi/RasQberry/rasqberry_environment.env
    # reload environment file
    . /home/pi/RasQberry/env-config.sh
  fi
}

do_menu_update_environment_file() {
  new_value=$(whiptail --inputbox "$1" $WT_HEIGHT $WT_WIDTH --title "Type in the new value" 3>&1 1>&2 2>&3)
  update_environment_file "$1" "$new_value"
}

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

do_rasqberry_install_autohotspot() {
  echo "installing autohotspot, credits: https://www.raspberryconnect.com/, find project on github: https://github.com/RaspberryConnect/AutoHotspot-Installer"
  cd /home/pi/RasQberry
  curl "https://www.raspberryconnect.com/images/hsinstaller/Autohotspot-Setup.tar.xz" -o AutoHotspot-Setup.tar.xz
  tar -xvJf AutoHotspot-Setup.tar.xz
  if [ "$INTERACTIVE" = True ]; then
      [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Running AutoHotspot installer script. When prompted to enter a number choose accordingly (most cases option 1). \n Credits: https://www.raspberryconnect.com/, Find project on GitHub: https://github.com/RaspberryConnect/AutoHotspot-Installer" 20 60 1
  fi
  sudo AutoHotspot/autohotspot-setup.sh
  cd
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

do_rasqberry_qtoken_update(){
  sudo -u pi -H -- sh -c /home/pi/RasQberry/demos/bin/rq_q_token.sh
}

do_toggle_messages() {
  [ "$RQ_NO_MESSAGES" = false ] && update_environment_file "RQ_NO_MESSAGES" "true" || update_environment_file "RQ_NO_MESSAGES" "false"
}

do_rasqberry_switch_branch() {
  # switch to branch
  cd /home/pi/RasQberry/
  #count the number of branches
  branch_counter=$(git branch -r| wc -l)
  #create whiptail menu with the branches
  branches=$(git branch -r | sed 's/\(.*\) -> \(.*\)/\2/')
  branches_menu=$(echo $branches | sed 's/ /\n/g')
  current_branch=$(git branch --show-current)
  #create whiptail menu with the branches, default value is current branch
  branch_choice=$(whiptail --inputbox "$branches_menu" $WT_HEIGHT $WT_WIDTH "$current_branch" --title "Type in the new branch (without 'origin/')" 3>&1 1>&2 2>&3)
  #get the branch name
  branch_name=$(echo "$branch_choice" | sed 's/\(.*\) -> \(.*\)/\2/')
  #switch to branch
  git checkout "$branch_name"
  if [ "$INTERACTIVE" = True ]; then
      whiptail --msgbox "Switched to branch: $branch_name" 20 60 1
  fi
}

# Boot
disable_raspi_config_at_boot() {
  if [ -e /etc/profile.d/raspi-config.sh ]; then
    rm -f /etc/profile.d/raspi-config.sh
    if [ -e /etc/systemd/system/getty@tty1.service.d/raspi-config-override.conf ]; then
      rm /etc/systemd/system/getty@tty1.service.d/raspi-config-override.conf
    fi
    telinit q
  fi
}

do_rasqberry_activate_bloch_autostart(){
# enable bloch autostart ?
  [ "$BLOCH_AUTORUN_ENABLED" = true ] && return 0;
  if [ "$BLOCH_AUTORUN_ASKED" = false ]; then
    DEFAULT=--defaultno
    whiptail --yesno \
      "Would you like to enable the BlochSphere autostart?" $DEFAULT 20 60 2
    RET=$?
    if [ $RET -eq 0 ]; then #selected yes
      #whiptail --msgbox "selected yes" 20 60 1
      echo "@/home/pi/RasQberry/demos/bin/rq_bloch_autostart.sh" >> /etc/xdg/lxsession/LXDE-pi/autostart
      update_environment_file "BLOCH_AUTORUN_ENABLED" "true"
      update_environment_file "BLOCH_AUTORUN_ASKED" "true"
    else # selected no
      #whiptail --msgbox "selected no" 20 60 1
      DEFAULT=--defaultno
      whiptail --yesno \
        "Would you like to be asked again to activate autostart?" $DEFAULT 20 60 2
      RET=$?
      if [ $RET -eq 1 ]; then #selected no
        update_environment_file "BLOCH_AUTORUN_ASKED" "true"
      fi
    fi
  fi
}

do_rasqberry_deactivate_bloch_autostart(){
# enable bloch autostart ?
  if [ "$BLOCH_AUTORUN_ENABLED" = true ]; then
    sed -i 's/@rq_bloch_autostart.sh//' /etc/xdg/lxsession/LXDE-pi/autostart
    update_environment_file "BLOCH_AUTORUN_ENABLED" "false"
  fi
}

do_finish() {
  disable_raspi_config_at_boot
  if [ $ASK_TO_REBOOT -eq 1 ]; then
    whiptail --yesno "Would you like to reboot now?" 20 60 2
    if [ $? -eq 0 ]; then # yes
      sync
      reboot
    fi
  fi
  exit 0
}

# VNC
rq_do_vnc() {
  if is_installed realvnc-vnc-server || apt-get install realvnc-vnc-server; then
    systemctl enable vncserver-x11-serviced.service &&
    systemctl start vncserver-x11-serviced.service &&
    STATUS=enabled
  fi
  if [ "$INTERACTIVE" = True ]; then
    [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "The VNC Server is $STATUS" 20 60 1
  fi
}

do_rasqberry_enable_desktop_vnc(){
  if [ "$INTERACTIVE" = True ]; then
    [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "enable vnc and configure desktop" 20 60 1
  fi
  if [ "$DESKTOPVNC_ENABLED" = false ]; then
    # setup wallpaper
    sudo -u pi -H -- sh -c 'mkdir -p /home/pi/.config/pcmanfm/LXDE-pi/'
    sudo -u pi -H -- sh -c 'cp /home/pi/RasQberry/bin/rq_desktop-items-0.conf /home/pi/.config/pcmanfm/LXDE-pi/desktop-items-0.conf'
    # add desktop icons and menu entries
    sudo -u pi -H -- sh -c 'cp -R /home/pi/RasQberry/desktop-icons/kivy.desktop /home/pi/Desktop/'
    sudo -u pi -H -- sh -c 'cp -R /home/pi/RasQberry/desktop-icons/bloch.desktop /home/pi/Desktop/'
    sudo -u pi -H -- sh -c 'cp -R /home/pi/RasQberry/desktop-icons/composer.desktop /home/pi/Desktop/'
    sudo -u pi -H -- sh -c 'cp -R /home/pi/RasQberry/desktop-icons/* /home/pi/.local/share/applications/'
    desktop-file-install /home/pi/RasQberry/desktop-entries/*.desktop
    # add menu categories
    sudo -u pi -i /home/pi/RasQberry/bin/add_menu.sh
    # add menu directories
    sudo -u pi -H -- sh -c 'cp -R /home/pi/RasQberry/directory-entries/* /home/pi/.local/share/desktop-directories'
    # file manager config
    if [ -f /home/pi/.config/libfm/libfm.conf ]; then
      sed -i 's/quick_exec=0/quick_exec=1/' /home/pi/.config/libfm/libfm.conf
    else
      sudo -u pi -H -- sh -c 'mkdir -p /home/pi/.config/libfm/; echo "[config]\nquick_exec=1\nsingle_click=1" > /home/pi/.config/libfm/libfm.conf'
    fi
    # desktop panel config
    [ ! -f /home/pi/.config/lxpanel/LXDE-pi/panels/panel ] \
      && sudo -u pi -H -- sh -c 'mkdir -p /home/pi/.config/lxpanel/LXDE-pi/panels/; cat /home/pi/RasQberry/bin/rq_lxpanel.conf > /home/pi/.config/lxpanel/LXDE-pi/panels/panel'
    # remove warning for unchanged password
    apt -y purge libpam-chksshpwd
    # fix missing xterm when using desktop icons
    ln -s /usr/bin/lxterminal /usr/bin/xterm
    # prevent welcome wizard to start. (run manually with "sudo piwiz", if needed)
    rm /etc/xdg/autostart/piwiz.desktop

    # install virtual keyboard
    apt -y install matchbox-keyboard

    # enable light
    do_rasqberry_enable_LED

    # enable VNC
    rq_do_vnc

    if [ "$INTERACTIVE" = True ]; then
      [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Desktop settings will become active after next reboot" 20 60 1
    fi
    ASK_TO_REBOOT=1
    update_environment_file "DESKTOPVNC_ENABLED" "true"
    # enable second vnc display (side-to-side)
    sudo -u pi /home/pi/RasQberry/bin/vnc_side-to-side.sh
    if [ "$INTERACTIVE" = True ]; then
      [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "enabled second vnc <ip address>:5902" 20 60 1
    fi
    echo "@/home/pi/RasQberry/bin/vnc_side-to-side.sh" >> /etc/xdg/lxsession/LXDE-pi/autostart
    if [ "$INTERACTIVE" = True ]; then
      [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Desktop and VNC are enabled.\\nSystem will reboot now" 20 60 1
    fi
    reboot
  fi
}

# Devices
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

do_rasqberry_enable_LED() {
  # enable rpi_ws281x python library
  cd /home/pi/
  pip3 install rpi_ws281x
  [ ! -d rpi-ws281x-python ] && sudo -u pi -H -- sh -c 'git clone https://github.com/rpi-ws281x/rpi-ws281x-python' || return 0
}

do_rasqberry_toggle_LED() {
  # turn on or off the LED light ring above the cryostat
  if [ -f /home/pi/RasQberry/.is_running_LED ]; then
    kill -15 `cat /home/pi/RasQberry/.is_running_LED`
    rm /home/pi/RasQberry/.is_running_LED
    python3 .local/bin/rq_LED-off.py -c
  else
    nohup python3 .local/bin/rq_LED-test.py -c &
    echo $! > /home/pi/RasQberry/.is_running_LED
  fi
}

rq_check_tft4() {
  [ `tvservice -n` == "device_name=ADA-MPI4008" ] && update_environment_file "RQ_IS_TFT4" "true" || update_environment_file "RQ_IS_TFT4" "false"
}

rq_check_hat() {
  [ -d /proc/device-tree/hat/ ] && update_environment_file "RQ_IS_HAT" "true" || update_environment_file "RQ_IS_HAT" "false"
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

do_rasqberry_enable_touch41(){
  if [ "$INTERACTIVE" = True ]; then
    [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "enable touch display\\nPart 1 " 20 60 1
  fi

  # enable 4'' touch display
  if [ "$IS_ENABLED_TOUCH4" = false ]; then
    sudo -u pi -H -- sh -c /home/pi/.local/bin/rq_enable_touch.sh
    ASK_TO_REBOOT=1
    if [ "$INTERACTIVE" = True ]; then
      [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Please exit and reboot" 20 60 1
    fi
  fi
}

do_rasqberry_enable_touch42(){
  if [ "$INTERACTIVE" = True ]; then
    [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "enable touch display\\nPart 2 " 20 60 1
  fi

  # check touchscreen calibration
  if [ "$IS_TFT_CALIBRATED" = false ] && [ "$IS_ENABLED_TOUCH4" = true ]; then
    cat /home/pi/RasQberry/bin/rq_99-calibration.conf > /etc/X11/xorg.conf.d/99-calibration.conf && update_environment_file "IS_TFT_CALIBRATED" "true"
    if [ "$INTERACTIVE" = True ]; then
      [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Touchscreen recalibrated for Bloch Demo\\nPlease exit and reboot" 20 60 1
    fi
    reboot
    return 0
  fi
}

#Drivers
rq_enable_gldriver() {
  if [ ! -e /boot/overlays/vc4-kms-v3d.dtbo ]; then
    if [ "$INTERACTIVE" = True ]; then
      [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Driver and kernel not present on your system. Please update" 20 60 2
    fi
    return 1
  fi
  for package in gldriver-test libgl1-mesa-dri; do
    if [ "$(dpkg -l "$package" 2> /dev/null | tail -n 1 | cut -d ' ' -f 1)" != "ii" ]; then
      missing_packages="$package $missing_packages"
    fi
  done
  if [ -n "$missing_packages" ] && ! apt-get install $missing_packages; then
    if [ "$INTERACTIVE" = True ]; then
      [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Required packages not found, please install: ${missing_packages}" 20 60 2
    fi
    return 1
  fi
  if is_pifour ; then
    if ! grep -q -E "^dtoverlay=vc4-fkms-v3d" $CONFIG; then
      ASK_TO_REBOOT=1
    fi
    sed $CONFIG -i -e "s/^dtoverlay=vc4-kms-v3d/#dtoverlay=vc4-kms-v3d/g"
    sed $CONFIG -i -e "s/^#dtoverlay=vc4-fkms-v3d/dtoverlay=vc4-fkms-v3d/g"
    if ! sed -n "/\[pi4\]/,/\[/ !p" $CONFIG | grep -q "^dtoverlay=vc4-fkms-v3d" ; then
      printf "[all]\ndtoverlay=vc4-fkms-v3d\n" >> $CONFIG
    fi
    STATUS="The fake KMS GL driver is enabled."
    update_environment_file "KMS_GL_ENABLED" "true"
  else
    if ! sed -n "/\[pi4\]/,/\[/ !p" $CONFIG | grep -q "^dtoverlay=vc4-kms-v3d" ; then
      ASK_TO_REBOOT=1
    fi
    sed $CONFIG -i -e "s/^dtoverlay=vc4-fkms-v3d/#dtoverlay=vc4-fkms-v3d/g"
    sed $CONFIG -i -e "s/^#dtoverlay=vc4-kms-v3d/dtoverlay=vc4-kms-v3d/g"
    if ! sed -n "/\[pi4\]/,/\[/ !p" $CONFIG | grep -q "^dtoverlay=vc4-kms-v3d" ; then
      printf "[all]\ndtoverlay=vc4-kms-v3d\n" >> $CONFIG
    fi
    STATUS="The full KMS GL driver is enabled."
    update_environment_file "KMS_GL_ENABLED" "true"
  fi
  if [ "$INTERACTIVE" = True ]; then
    [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "$STATUS \\nIt will become active after next reboot" 20 60 1
  fi
}

rq_check_gldriver() {
  if [ "$KMS_GL_ENABLED" = true ]; then
    return 0
  else
    rq_enable_gldriver
    reboot
    ASK_TO_REBOOT=1
    return 1
  fi
}