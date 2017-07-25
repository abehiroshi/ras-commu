#!/bin/sh

sudo apt-get install -y i2c-tools build-essential python-dev python-pip python-imaging python-smbus
sudo pip install RPi.GPIO

if [ ! -d /home/pi/Adafruit_Python_SSD1306 ]; then
  cd /home/pi
  git clone https://github.com/adafruit/Adafruit_Python_SSD1306.git
  cd Adafruit_Python_SSD1306
  sudo python setup.py install
fi

mkdir -p /home/pi/font/misakifont
curl -L http://www.geocities.jp/littlimi/arc/misaki/misaki_ttf_2015-04-10.zip -o /home/pi/font/misakifont/misaki_ttf_2015-04-10.zip
cd /home/pi/font/misakifont
unzip misaki_ttf_2015-04-10.zip
