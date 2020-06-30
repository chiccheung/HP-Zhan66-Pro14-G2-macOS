#!/bin/sh

sudo kextload -v /usr/local/share/DirectHW.kext >> /dev/null 2>&1

cd $(dirname $0)/Bins
echo "\x00\x00\x00\x00\x00\x00\x00\x00\n" |sudo ./wrmem 0xfed159a0 8 >> /dev/null 2>&1
sudo ./rdmem 0xfed159A0 16 | xxd -g 1 >> /dev/null 2>&1
sudo chown -R root:wheel VoltageShift.kext >> /dev/null 2>&1
sudo ./voltageshift power 25 35
sudo ./voltageshift write 0x1a2 0x8640000 >> /dev/null 2>&1
sudo ./voltageshift write 0x1fc 0x24005E >> /dev/null 2>&1

sudo kextunload -v /usr/local/share/DirectHW.kext >> /dev/null 2>&1

echo "unlockTDP Done!"
