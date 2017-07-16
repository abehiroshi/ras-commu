#!/bin/sh

echo "create /etc/udev/rules.d/40-ak-020.rules ..."
echo;
cat <<EOS | sudo tee /etc/udev/rules.d/40-ak-020.rules
# ABIT AK-020
ATTR{idVendor}=="15eb", ATTR{idProduct}=="a403", RUN+="usb_modeswitch '%b/%k'
echo;

echo ""
echo;
cat <<EOS | sudo tee /etc/usb_modeswitch.d/15eb:a403
DefaultVendor = 0x15eb
DefaultProduct = 0xa403
TargetVendor = 0x15eb
TargetProduct = 0x7d0e
StandardEject = 1
WaitBefore=2
EOS
echo;
