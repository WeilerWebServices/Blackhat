#!/bin/bash

# Clone All Wireshark Repositories

echo "Make Wireshark Folder"

mkdir Wireshark

echo "Clone All Wireshark Repositories"

git clone https://github.com/wireshark/wireshark
git clone https://github.com/wireshark/wireshark-containers
git clone https://github.com/wireshark/wireshark-windows-dev-docker
git clone https://github.com/wireshark/wireshark-ubuntu-dev-docker
git clone https://github.com/wireshark/winpcap
git clone https://github.com/wireshark/happy-shark

echo "Cleaning up Wireshark Repositories"

cd wireshark/
rm -rf .git/
cd ../wireshark-containers/
rm -rf .git/
cd ../wireshark-windows-dev-docker/
rm -rf .git/
cd ../wireshark-ubuntu-dev-docker/
rm -rf .git/
cd ../winpcap/
rm -rf .git/
cd ../happy-shark/
rm -rf .git/
