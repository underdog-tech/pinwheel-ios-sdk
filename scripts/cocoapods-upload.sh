#!/bin/bash

# This will cause the shell to exit immediately if a simple command exits with a nonzero exit value.
set -e

echo \>\> Setting up cocoapods auth
echo "machine trunk.cocoapods.org" >> ~/.netrc
echo "login $COCOAPODS_TRUNK_EMAIL" >> ~/.netrc
echo "password $COCOAPODS_TRUNK_TOKEN" >> ~/.netrc

# Push the pod to CocoaPods
echo \>\>  Pushing cocoapods
pod trunk push PinwheelSDK.podspec

echo ">> Done"