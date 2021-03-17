#!/bin/bash

echo "Building module..."
python3 setup.py build >/dev/null

echo "Installing module..."
sudo python3 setup.py install >/dev/null

echo "Building binary..."
# -F creates a single binary
# -n sets the binary name
pyinstaller --log-level ERROR -F -n ite8291r3-ctl ite8291r3_ctl/__main__.py >/dev/null

echo "Applying SETUID bit..."
sudo chown root:root dist/ite8291r3-ctl
sudo chmod u+s dist/ite8291r3-ctl

AUCC_PATH=`which ite8291r3-ctl`
echo "Copying binary to $AUCC_PATH..."
sudo cp dist/ite8291r3-ctl $AUCC_PATH
