#!/bin/bash

BINARY_NAME="ite8291r3-ctl"

echo "Building module..."
python3 setup.py build >/dev/null

echo "Installing module..."
sudo python3 setup.py install >/dev/null

echo "Building binary..."
# -F creates a single binary
# -n sets the binary name
pyinstaller --log-level ERROR -F -n $BINARY_NAME ite8291r3_ctl/__main__.py >/dev/null

echo "Applying SETUID bit..."
sudo chown root:root dist/$BINARY_NAME
sudo chmod u+s dist/$BINARY_NAME

BINARY_PATH=`which $BINARY_NAME`
echo "Copying binary to $BINARY_PATH..."
sudo cp dist/$BINARY_NAME $BINARY_PATH
