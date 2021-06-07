#!/bin/bash

# starting setup for recon map
figlet -f slant.tlf "#recon-map"
echo -e "\e[33m by: @ WebCipher101"
im=${USER}

echo -e "\e[35m><><>< Hello $im :) ><><><"

echo -e "\e[37m          *** setup for recon-map is started            ***     "
sudo apt-get update
sleep 15
sudo apt-get install figlet
sleep 10
sudo apt-get install sslscan
sleep 10
sudo apt-get install subfinder
sleep 10
sudo apt-get install assetfinder
sleep 10
sudo apt-get install amass
sleep 15
sudo apt-get install knockpy
sleep 15

figlet -f slant.tlf "DONE . ."

echo -e "\e[96m(\_/)"
echo -e "\e[96m(* *) ALL DONE"
echo -e "\e[96m \w/ @ webcipher101"

sleep 2
