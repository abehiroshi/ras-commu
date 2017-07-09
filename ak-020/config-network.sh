#!/bin/sh

if ! sudo grep soracom_ak-020 /etc/network/interfaces; then
cat << 'EOS' | sudo tee -a /etc/network/interfaces

allow-hotplug wwan0
iface wwan0 inet ppp
    provider soracom_ak-020
EOS
fi
