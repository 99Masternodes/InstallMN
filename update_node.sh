#!/bin/bash

TARBALLURL="https://github.com/99Masternodes/NMN/releases/download/v1.1.0.0/ubuntu16.04-daemon.zip"
TARBALLNAME="ubuntu16-daemon.zip"
NMNVERSION="1.1.0.0"

clear
echo "This script will update your masternode to version $NMNVERSION"
read -p "Press Ctrl-C to abort or any other key to continue. " -n1 -s
clear
echo "Please enter your password to enter administrator mode:"
sudo true
echo "Shutting down masternode..."
nmn-cli stop
echo "Installing NMN $NMNVERSION"
mkdir ./nmn-temp && cd ./nmn-temp
wget $TARBALLURL
unzip $TARBALLNAME
sudo rm $TARBALLNAME
yes | sudo cp -rf nmnd /usr/local/bin
yes | sudo cp -rf nmn-cli /usr/local/bin
sudo chmod +x /usr/local/bin/nmnd
sudo chmod +x /usr/local/bin/nmn-cli
cd ..
sed -i '/^addnode/d' ~/.nmn/nmn.conf
cat <<EOL >>  ~/.nmn/nmn.conf
EOL
echo "Restarting NMN daemon..."
nmnd
clear
read -p "Please wait at least 5 minutes for the wallet to load, then press any key to continue." -n1 -s
clear
echo "Starting masternode..." # TODO: Need to wait for wallet to load before starting...
nmn-cli masternode status
