#!/bin/bash

choice=$(gum choose \
  --header="Power Menu" \
  --height=5 \
  "Reboot" "Poweroff" "Shutdown" "Cancel")

case "$choice" in
  Reboot)
     reboot
    ;;
  Poweroff)
    poweroff
    ;;
  Shutdown)
     shutdown -h now
    ;;
  Cancel|"")
    exit 0
    ;;
esac
