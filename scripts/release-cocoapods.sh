#!/bin/bash

# This will cause the shell to exit immediately if a simple command exits with a nonzero exit value.
set -e

echo \>\> ruby version: $(ruby -v)
rbenv global 3.2.2
echo \>\> ruby version: $(ruby -v)

echo \>\> Installing ruby gems
bundle install
echo \>\> Successfully installed gems with bundle install

echo \>\> Setting up cocoapods auth
echo "machine trunk.cocoapods.org" >> ~/.netrc
echo "login $COCOAPODS_TRUNK_EMAIL" >> ~/.netrc
echo "password $COCOAPODS_TRUNK_TOKEN" >> ~/.netrc
chmod 0600 /Users/distiller/.netrc

echo \>\> Pod me
pod trunk me

CURRENT_GIT_TAG=$(git describe --tags --abbrev=0)
DESCRIPTION="Pushing pinwheel-ios-sdk version $CURRENT_GIT_TAG to Cocoapods"
echo \>\> $DESCRIPTION
pod trunk push PinwheelSDK.podspec

echo ">> Done"