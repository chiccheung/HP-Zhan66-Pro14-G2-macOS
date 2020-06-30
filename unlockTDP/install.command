#!/bin/sh

sudo mount -uw /
sudo killall Finder
sudo mkdir -p /usr/local/lib
sudo mkdir -p /usr/local/share

cd $(dirname $0)/Resources
sudo cp -r ./DirectHW.kext /usr/local/share/DirectHW.kext
sudo cp -r ./DirectHW.framework /Library/Frameworks/DirectHW.framework
sudo cp -r ./libDirectHW.a /usr/local/lib/libDirectHW.a
sudo cp -r ./libDirectHW.dylib /usr/local/lib/libDirectHW.dylib

sudo chmod -R 755 /usr/local/share/DirectHW.kext
sudo chmod -R 755 /Library/Frameworks/DirectHW.framework
sudo chmod 644 /usr/local/lib/libDirectHW.a
sudo chmod 644 /usr/local/lib/libDirectHW.dylib

sudo chown -R root:wheel /usr/local/share/DirectHW.kext
sudo chown -R root:wheel /Library/Frameworks/DirectHW.framework

echo "Done!"
