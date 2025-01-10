#!/bin/bash
# Script: status.sh
# Purpose: start 4 screens with their commands
# Author: Bjørn Martin Hegnes
# -------------------------------------------------------
# stop confliting wifi prosseses
sudo systemctl stop wpa_supplicant
sudo service NetworkManager stop
# start gps
sudo gpsd /dev/ttyUSB0 -F /var/run/gpsd.sock
#start screen
screen -dmS status
screen -S status -X screen watch bash -c /home/req/status.sh
# hcxdumptool
screen -dmS wlan1
screen -S wlan1 -X screen sudo hcxdumptool -i wlx00c0caaaff87 -w /opt/wardriving/hashes/wlx00c0caaaff87/Wi-Fi_PMKI-wlan1-$(date +"%Y_%m_%d_%I_%M_%p").pcapng --rds=3
screen -dmS wlan2
screen -S wlan2 -X screen sudo hcxdumptool -i wlx9cefd5fa9b94 -w /opt/wardriving/hashes/wlx9cefd5fa9b94/Wi-Fi_PMKI-wlan2-$(date +"%Y_%m_%d_%I_%M_%p").pcapng --rds=3
# kismet
screen -dmS kismet
screen -S kismet -X screen sudo kismet -c hci0 -c wlan1 -p /opt/wardriving/kismetbt
