#!/usr/bin/bash
sudo apt install libcurl4=7.88.1-10+deb12u8
sudo apt install libcurl4-openssl-dev libcurl4=7.88.1-10+deb12u8
sudo apt remove libcurl4 libcurl4-openssl-dev
sudo apt update
sudo apt install libcurl4=7.88.1-10+deb12u8 libcurl4-openssl-dev
sudo nano /etc/apt/sources.list
sudo apt update -y

