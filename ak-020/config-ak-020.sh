#!/bin/sh

echo "setting ak-020 for soracom"

if ! sudo grep replacedefaultroute /etc/ppp/peers/soracom_ak-020; then
cat <<EOS | sudo tee -a /etc/ppp/peers/soracom_ak-020
hide-password
noauth
connect "/usr/sbin/chat -v -f /etc/chatscripts/soracom_ak-020"
debug
/dev/ttyAK020
460800
defaultroute
noipdefault
user "sora"
remotename soracom_ak-020
ipparam soracom_ak-020

usepeerdns
persist
replacedefaultroute
EOS
fi

if ! sudo grep soracom.io /etc/chatscripts/soracom_ak-020; then
sudo sed -i -e "s/'' ATZ/'' ATH\n\
OK AT+CFUN=1\n\
OK ATZ\n\
OK 'ATQ0 V1 E1 S0=0 \&C1 \&D2'\n\
OK AT+CGDCONT=1,\"IP\",\"soracom.io\"\
/" /etc/chatscripts/soracom_ak-020
fi
