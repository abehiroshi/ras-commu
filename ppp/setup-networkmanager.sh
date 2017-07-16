#!/bin/sh

if [ ! -d /etc/NetworkManager ]; then
  sudo apt-get install -y network-manager
  sudo apt-get remove -y dhcpcd5
  echo;
  echo "Please reboot. Execute this script again."
fi

echo "create /etc/NetworkManager/system-connections/soracom ..."
echo;
cat <<EOS | sudo tee /etc/NetworkManager/system-connections/soracom
[connection]
id=soracom
uuid=$(cat /proc/sys/kernel/random/uuid)
type=gsm
autoconnect=true

[ppp]
refuse-eap=true
refuse-mschap=true
refuse-mschapv2=true

[ipv6]
method=auto

[ipv4]
method=auto

[serial]
baud=460800

[gsm]
number=*99***1#
username=sora
password=sora
apn=soracom.io
EOS
sudo chmod 600 /etc/NetworkManager/system-connections/soracom
echo;
