#!/bin/bash
sudo dpkg --add-architecture i386
sudo mkdir -pm755 /etc/apt/keyrings
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key -
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/trixie/winehq-trixie.sources
sudo apt update
sudo apt install winehq-staging=9.21~trixie-1 wine-staging=9.21~trixie-1 wine-staging-amd64=9.21~trixie-1 wine-staging-i386=9.21~trixie-1
