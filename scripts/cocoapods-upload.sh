#!/bin/bash

# This will cause the shell to exit immediately if a simple command exits with a nonzero exit value.
set -e

echo \>\> ruby version: $(ruby -v)
rbenv global 3.2.2
echo \>\> ruby version: $(ruby -v)
# echo \>\> which ruby: $(which ruby)
# brew install ruby
# echo \>\> which ruby: $(which ruby)

echo \>\> Installing ruby gems
# rm Gemfile.lock
bundle install
echo \>\> Successfully installed gems with bundle install

# echo \>\> Updating cocoapods
# bundle update
# echo \>\> Updated cocoapods

echo \>\> Setting up cocoapods auth
echo "machine trunk.cocoapods.org" >> ~/.netrc
echo "login $COCOAPODS_TRUNK_EMAIL" >> ~/.netrc
echo "password $COCOAPODS_TRUNK_TOKEN" >> ~/.netrc

# Push the pod to CocoaPods
echo \>\>  Pod update
pod update
echo \>\>  Pushing cocoapods
pod trunk push PinwheelSDK.podspec

echo ">> Done"