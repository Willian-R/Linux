#! /bin/sh
wget http://ftp.midnight-commander.org/mc-4.8.27.tar.xz
tar -xvf mc-4.8.27.tar.xz
cd mc-4.8.27
./configure
sudo make
sudo make install clean
mc