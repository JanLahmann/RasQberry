#!/bin/sh

# ############# Qoffee Maker methods #############

do_rasqberry_Qoffee_clone() {
  #check for docker
  if docker version | grep -q 'command not found'; then
    whiptail --yesno \ "It seems that docker is not installed. Would you like to install it now? If you choose not to, the start will probably fail." $DEFAULT 20 60 2
    RET=$?
    if [ $RET -eq 0 ]; then # selected yes
      do_rq_enable_docker
    fi
  fi

  # clone Qoffee-Maker github repo
  if [ "$INTERACTIVE" = true ]; then
    [ "$RQ_NO_MESSAGES" = false ] && whiptail --yesno \ "Docker containers are known to cause problems when running the AutoHotspot.
    If you are experiencing trouble while using docker, try to uninstall the AutoHotspot by choosing option 4 during the installation.
    Would you like to continue the installation?" $DEFAULT 20 60 2
    RET=$?
  fi
  if [ $RET -eq 1 ]; then # selected no
    exit
  fi
  if [ "$QOFFEE_CLONED" = false ]; then
    #newgrp docker
    #docker version
    cd /home/pi/ || exit
    sudo -u pi -H -- sh -c 'git clone https://github.com/JanLahmann/Qoffee-Maker'
    cd /home/pi/Qoffee-Maker || exit
    update_environment_file "QOFFEE_CLONED" "true"
    if [ "$INTERACTIVE" = true ]; then
        [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Qoffee-Maker Demo cloned" 20 60 1
    fi
  else
    cd /home/pi/Qoffee-Maker || exit
    sudo -u pi -H -- sh -c 'git pull origin $BRANCH'
  fi
  # check if .env file exists
  if [ ! -f .env ]; then
    cp env-template .env
    echo "/home/pi/Qoffee-Maker/.env file did not exist. A template .env file has been created. Please modify it based on the env-template or functionalities will not work!"
    if [ "$INTERACTIVE" = true ]; then
        [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "/home/pi/Qoffee-Maker/.env file did not exist. A template .env file has been created. Please modify it based on the env-template or functionalities will not work!" 20 60 1
    fi
  fi
}

do_rasqberry_Qoffee_download() {
  # clone Qoffee-Maker github repo
  do_rasqberry_Qoffee_clone
  # Save current sysctl net.ipv4.ip_forward state
  previous_sysctl_state=$(sudo -u pi -H -- sh -c 'sysctl net.ipv4.ip_forward | sed "s/ //g"')
  sudo -u pi -H -- sh -c 'sudo sed -i "s/.*net.ipv4.ip_forward=.*/net.ipv4.ip_forward=1/gm" /etc/sysctl.conf'
  sudo -u pi -H -- sh -c 'sudo sysctl --system'
  cd /home/pi/Qoffee-Maker/ || exit
  # check if Qoffee-Maker download and setup to be done
  if [ "$QOFFEE_DOWNLOADED" = false ]; then
    sudo -u pi -H -- sh -c 'docker pull ghcr.io/janlahmann/qoffee-maker && cp -uR /home/pi/RasQberry/desktop-icons/qoffee-download.desktop /home/pi/Desktop/'
    update_environment_file "QOFFEE_DOWNLOADED" "true"
    if [ "$INTERACTIVE" = true ]; then
        [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Qoffee-Maker Demo image downloaded" 20 60 1
    fi
  fi
  # download & start Qoffee-Maker docker image
  if [ "$INTERACTIVE" = true ]; then
      [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "will download and start Qoffee-Maker Demo. Please close Chrome at the end." 20 60 1
  fi
  echo "\n\nStart Qoffee-Maker on command line in /home/pi/Qoffee-Maker/ with\n  docker run --name qoffee --rm -itp 8887:8887 --env-file .env ghcr.io/janlahmann/qoffee-maker \n\n"
  sudo -u pi -H -- sh -c 'docker pull ghcr.io/janlahmann/qoffee-maker && docker run -d --name qoffee --rm -itp 8887:8887 --env JUPYTER_TOKEN=super-secret-token --env-file .env ghcr.io/janlahmann/qoffee-maker && sleep 5 && chromium-browser http://127.0.0.1:8887/?token=super-secret-token'
  echo "please wait for cleanup before closing the terminal"
  do_rasqberry_Qoffee_stop
  echo "Terminal can now be closed"
}

do_rasqberry_Qoffee_local() {
  # clone Qoffee-Maker github repo
  do_rasqberry_Qoffee_clone
  # Save current sysctl net.ipv4.ip_forward state
  previous_sysctl_state=$(sudo -u pi -H -- sh -c 'sysctl net.ipv4.ip_forward | sed "s/ //g"')
  sudo -u pi -H -- sh -c 'sudo sed -i "s/.*net.ipv4.ip_forward=.*/net.ipv4.ip_forward=1/gm" /etc/sysctl.conf'
  sudo -u pi -H -- sh -c 'sudo sysctl --system'
  cd /home/pi/Qoffee-Maker/ || exit
  # check if Qoffee-Maker docker image needs to be build
  if [ "$QOFFEE_INSTALLED" = false ]; then
    # build with node 15 instead of node 14
    sudo -u pi -H -- sh -c 'cp DockerfileArm DockerfileArm-15'
    sed -i 's/node:14/node:15/' DockerfileArm-15
    sudo -u pi -H -- sh -c 'docker build -f DockerfileArm-15 -t qoffee . && cp -uR /home/pi/RasQberry/desktop-icons/qoffee-local.desktop /home/pi/Desktop/'
    update_environment_file "QOFFEE_INSTALLED" "true"
    sudo -u pi -H -- sh -c 'rm DockerfileArm-15'
    if [ "$INTERACTIVE" = true ]; then
        [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Qoffee-Maker container built locally" 20 60 1
    fi
  fi
  # start Qoffee-Maker docker container
  if [ "$INTERACTIVE" = true ]; then
      [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "will start Qoffee-Maker Demo. Please close Chrome at the end." 20 60 1
  fi
  echo "\n\nStart Qoffee-Maker on command line in /home/pi/Qoffee-Maker/ with\n  docker run --name qoffee --rm -itp 8887:8887 --env-file .env qoffee:latest \n\n"
  sudo -u pi -H -- sh -c 'docker run -d --name qoffee --rm -itp 8887:8887 --env JUPYTER_TOKEN=super-secret-token --env-file .env qoffee:latest && sleep 5 && chromium-browser http://127.0.0.1:8887/?token=super-secret-token'
  echo "please wait for cleanup before closing the terminal"
  do_rasqberry_Qoffee_stop
  echo "Terminal can now be closed"
}

do_rasqberry_Qoffee_rebuild() {
  # stop all qoffee docker containers
  sudo -u pi -H -- sh -c 'docker stop $(docker ps -q --filter name=qoffee )'
  update_environment_file "QOFFEE_DOWNLOADED" "false"
  update_environment_file "QOFFEE_INSTALLED" "false"
}

do_rasqberry_Qoffee_stop() {
  # stop all qoffee docker containers
  # Restore previous sysctl net.ipv4.ip_forward state
  sudo -u pi -H -- sh -c "sudo sed -i "s/.*net.ipv4.ip_forward=.*/$previous_sysctl_state/gm" /etc/sysctl.conf"
  sudo -u pi -H -- sh -c 'sudo sysctl --system'
  echo "stopping all qoffee containers"
  sudo -u pi -H -- sh -c 'docker stop $(docker ps -q --filter name=qoffee )'
}






