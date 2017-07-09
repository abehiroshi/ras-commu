#!/bin/sh

sudo pon soracom_ak-020
sleep 10
echo "Global IP Address: $(curl -s globalip.me)"
echo "Host: $(host $(curl -s globalip.me))"
sudo poff soracom_ak-020
