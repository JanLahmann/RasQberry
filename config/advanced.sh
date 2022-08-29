#!/bin/sh

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