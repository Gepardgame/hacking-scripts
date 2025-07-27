#!/bin/bash

# Tailscale
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
sudo sysctl -p /etc/sysctl.d/99-tailscale.conf
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up --ssh --advertise-tags="tag:kali"

# Tools
sudo apt-get update -y
sudo apt remove -y --purge ruby ruby-dev rubygems
sudo apt install -y python3-impacket feroxbuster hydra git mingw-w64 ssh python3 make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl git libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev john john-data zip unzip ruby ruby-dev rubygems unix-privesc-check python3-pip
sudo gem install wpscan
pip install updog pyftpdlib

mkdir privesc
curl -s https://raw.githubusercontent.com/itm4n/PrivescCheck/master/PrivescCheck.ps1 -o privesc/PrivescCheck.ps1
curl -s https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh -o privesc/les.sh
curl -s https://github.com/bitsadmin/wesng/archive/refs/heads/master.zip -o privesc/master.zip
