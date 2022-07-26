export $(grep -v "^#" "/home/pi/RasQberry/environment.env" | xargs -d "\n")

update_environment_file () {
  sed -i "s/^$1=.*/$1=$2/gm" /home/pi/RasQberry/environment.env
  export $(grep -v "^#" "/home/pi/RasQberry/environment.env" | xargs -d "\n")
}

export -f update_environment_file