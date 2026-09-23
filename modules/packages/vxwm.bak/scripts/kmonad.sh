#!/bin/sh

# Configuration: Change this to your kmonad service name in /var/service/
SERVICE_NAME="kmonad"

# Check if the service is currently up
# 'sv status' returns 0 if the service is running, but we check the output for 'run'
if sudo sv status "$SERVICE_NAME" | grep -q '^run:'; then
    # Service is running, let's stop it
    sudo sv down "$SERVICE_NAME"
    notify-send -u low -i input-keyboard "KMonad" "Service Stopped - Default Layout"
else
    # Service is down, let's start it
    sudo sv up "$SERVICE_NAME"
    notify-send -u low -i input-keyboard "KMonad" "Service Started - Custom Layout"
fi
