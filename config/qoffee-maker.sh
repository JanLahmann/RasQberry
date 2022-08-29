#!/bin/sh

# ############# Qoffee Maker methods #############

do_rasqberry_Qoffee_clone() {
  # clone Qoffee-Maker github repo
  if [ "$QOFFEE_CLONED" = false ]; then
    #newgrp docker
    #docker version
    cd /home/pi/
    sudo -u pi -H -- sh -c 'git clone https://github.com/JanLahmann/Qoffee-Maker'
    update_environment_file "QOFFEE_CLONED" "true"
    if [ "$INTERACTIVE" = True ]; then
        [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Qoffee-Maker Demo cloned" 20 60 1
    fi
  else
    cd /home/pi/Qoffee-Maker
    sudo -u pi -H -- sh -c 'git pull origin $BRANCH'
  fi
  # check if .env file exists
  if [ ! -f .env ]; then
    echo "/home/pi/Qoffee-Maker/.env file does not exist. Please create it based on the env-template"
    if [ "$INTERACTIVE" = True ]; then
        [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "/home/pi/Qoffee-Maker/.env file does not exist. Please create it based on the env-template" 20 60 1
    fi
    exit 1
  fi
}

do_rasqberry_Qoffee_download() {
  # clone Qoffee-Maker github repo
  do_rasqberry_Qoffee_clone
  cd /home/pi/Qoffee-Maker/
  # check if Qoffee-Maker download and setup to be done
  if [ "$QOFFEE_DOWNLOADED" = false ]; then
    sudo -u pi -H -- sh -c 'docker pull ghcr.io/janlahmann/qoffee-maker && cp -uR /home/pi/RasQberry/desktop-icons/qoffee-download.desktop /home/pi/Desktop/'
    update_environment_file "QOFFEE_DOWNLOADED" "true"
    if [ "$INTERACTIVE" = True ]; then
        [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Qoffee-Maker Demo image downloaded" 20 60 1
    fi
  fi
  # download & start Qoffee-Maker docker image
  if [ "$INTERACTIVE" = True ]; then
      [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "will download and start Qoffee-Maker Demo. Please close Chrome at the end." 20 60 1
  fi
  echo "\n\nStart Qoffee-Maker on command line in /home/pi/Qoffee-Maker/ with\n  docker run --name qoffee --rm -itp 8887:8887 --env-file .env ghcr.io/janlahmann/qoffee-maker \n\n"
  sudo -u pi -H -- sh -c 'docker pull ghcr.io/janlahmann/qoffee-maker && docker run -d --name qoffee --rm -itp 8887:8887 --env JUPYTER_TOKEN=super-secret-token --env-file .env ghcr.io/janlahmann/qoffee-maker && sleep 5 && chromium-browser http://127.0.0.1:8887/?token=super-secret-token'
  echo "please wait for cleanup before closing the terminal"
  do_rasqberry_Qoffee_stop
  echo "Termminal can now be closed"
}

do_rasqberry_Qoffee_local() {
  # clone Qoffee-Maker github repo
  do_rasqberry_Qoffee_clone
  cd /home/pi/Qoffee-Maker/
  # check if Qoffee-Maker docker image needs to be build
  if [ "$QOFFEE_INSTALLED" = false ]; then
    # build with node 15 instead of node 14
    sudo -u pi -H -- sh -c 'cp DockerfileArm DockerfileArm-15'
    sed -i 's/node:14/node:15/' DockerfileArm-15
    sudo -u pi -H -- sh -c 'docker build -f DockerfileArm-15 -t qoffee . && cp -uR /home/pi/RasQberry/desktop-icons/qoffee-local.desktop /home/pi/Desktop/'
    update_environment_file "QOFFEE_INSTALLED" "true"
    sudo -u pi -H -- sh -c 'rm DockerfileArm-15'
    if [ "$INTERACTIVE" = True ]; then
        [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "Qoffee-Maker container build locally" 20 60 1
    fi
  fi
  # start Qoffee-Maker docker container
  if [ "$INTERACTIVE" = True ]; then
      [ "$RQ_NO_MESSAGES" = false ] && whiptail --msgbox "will start Qoffee-Maker Demo. Please close Chrome at the end." 20 60 1
  fi
  echo "\n\nStart Qoffee-Maker on command line in /home/pi/Qoffee-Maker/ with\n  docker run --name qoffee --rm -itp 8887:8887 --env-file .env qoffee:latest \n\n"
  sudo -u pi -H -- sh -c 'docker run -d --name qoffee --rm -itp 8887:8887 --env JUPYTER_TOKEN=super-secret-token --env-file .env qoffee:latest && sleep 5 && chromium-browser http://127.0.0.1:8887/?token=super-secret-token'
  echo "please wait for cleanup before closing the terminal"
  do_rasqberry_Qoffee_stop
  echo "Termminal can now be closed"
}

do_rasqberry_Qoffee_rebuild() {
# stop all qoffee docker containers
  sudo -u pi -H -- sh -c 'docker stop $(docker ps -q --filter name=qoffee )'
  update_environment_file "QOFFEE_DOWNLOADED" "false"
  update_environment_file "QOFFEE_INSTALLED" "false"
}

do_rasqberry_Qoffee_stop() {
# stop all qoffee docker containers
  echo "stopping all qoffee containers"
  sudo -u pi -H -- sh -c 'docker stop $(docker ps -q --filter name=qoffee )'
}






