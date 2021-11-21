#!/bin/bash

DDIABLO=`pwd`

echo '=== Installing prerequisites ==='
sudo apt update
sudo apt -y install i2c-tools python3-pygame python3-rpi.gpio python-pygame python-rpi.gpio

echo '=== Removing I2C devices from the blacklisting ==='
sudo cp /etc/modprobe.d/raspi-blacklist.conf /etc/modprobe.d/raspi-blacklist.conf.old
sudo sed -i 's/^blacklist i2c-bcm2708/#\0    # We need this enabled for I2C add-ons, e.g. PiBorg Diablo/g' /etc/modprobe.d/raspi-blacklist.conf

echo '=== Adding I2C devices to auto-load at boot time ==='
sudo cp /etc/modules /etc/modules.old
sudo sed -i '/^\s*i2c-dev\s*/d' /etc/modules
sudo sed -i '/^\s*i2c-bcm2708\s*/d' /etc/modules
sudo sed -i '/^#.*Diablo.*/d' /etc/modules
sudo bash -c "echo '' >> /etc/modules"
sudo bash -c "echo '# Kernel modules needed for I2C add-ons, e.g. PiBorg Diablo' >> /etc/modules"
sudo bash -c "echo 'i2c-dev' >> /etc/modules"
sudo bash -c "echo 'i2c-bcm2708' >> /etc/modules"

echo '=== Adding user "pi" to the I2C permissions list ==='
sudo adduser pi i2c

echo '=== Make scripts executable ==='
chmod a+x *.py
chmod a+x *.sh

echo '=== Create a desktop shortcut for the GUI example ==='
DIABLO_SHORTCUT="${HOME}/Desktop/Diablo.desktop"
echo "[Desktop Entry]" > ${DIABLO_SHORTCUT}
echo "Encoding=UTF-8" >> ${DIABLO_SHORTCUT}
echo "Version=1.0" >> ${DIABLO_SHORTCUT}
echo "Type=Application" >> ${DIABLO_SHORTCUT}
echo "Exec=${DDIABLO}/diabloGui.py" >> ${DIABLO_SHORTCUT}
echo "Icon=${DDIABLO}/piborg.ico" >> ${DIABLO_SHORTCUT}
echo "Terminal=false" >> ${DIABLO_SHORTCUT}
echo "Name=Diablo Demo GUI" >> ${DIABLO_SHORTCUT}
echo "Comment=Diablo demonstration GUI" >> ${DIABLO_SHORTCUT}
echo "Categories=Application;Development;" >> ${DIABLO_SHORTCUT}

echo '=== Finished ==='
echo ''
echo 'Your Raspberry Pi should now be set up for running PiBorg Diablo'
echo 'Please restart your Raspberry Pi to ensure the I2C driver is running'
