#!/bin/sh -eux
apt update
apt dist-upgrade -y
apt install -y git tclsh pkg-config cmake libssl-dev build-essential zlib1g-dev
git clone https://github.com/Haivision/srt
cd srt
./configure --prefix=/usr
make
make install
cd ..
git clone https://github.com/Edward-Wu/srt-live-server.git
cd srt-live-server
make
cd bin
nohup ./sls -c ../sls.conf &
iptables -A INPUT -m state --state NEW -p udp --dport 8080 -j ACCEPT
netfilter-persistent save
