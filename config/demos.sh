#!/bin/sh

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

do_rasqberry_deactivate_bloch_autostart(){
# enable bloch autostart ?
  if [ "$BLOCH_AUTORUN_ENABLED" = true ]; then
    sed -i 's/@rq_bloch_autostart.sh//' /etc/xdg/lxsession/LXDE-pi/autostart
    update_environment_file "BLOCH_AUTORUN_ENABLED" "false"
  fi
}

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