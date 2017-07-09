#!/bin/sh

sudo apt-get -y install pppconfig

if ! sudo grep ttyAK020 /etc/udev/rules.d/40-ak-020.rules; then
cat << 'EOS' | sudo tee /etc/udev/rules.d/40-ak-020.rules
ACTION=="add",\
  ATTRS{idVendor}=="15eb",\
  ATTRS{idProduct}=="a403",\
  RUN+="/usr/sbin/usb_modeswitch --std-eject --default-vendor 0x15eb --default-product 0xa403 --target-vendor 0x15eb --target-product 0x7d0e"

ACTION=="add",\
  ATTRS{idVendor}=="15eb",\
  ATTRS{idProduct}=="7d0e",\
  RUN+="/sbin/modprobe usbserial vendor=0x15eb product=0x7d0e"

ATTRS{../idVendor}=="15eb",\
  ATTRS{../idProduct}=="7d0e",\
  ATTRS{bNumEndpoints}=="03",\
  ATTRS{bInterfaceNumber}=="02",\
  SYMLINK+="ttyAK020",\
  ENV{SYSTEMD_WANTS}+="ifup@wwan0.service"
EOS

echo reboot..
sudo reboot
fi
