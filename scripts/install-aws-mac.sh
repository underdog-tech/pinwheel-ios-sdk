#!/bin/bash

PACKAGE_FILENAME="AWSCLIV2.pkg"
# This will cause the shell to exit immediately if a simple command exits with a nonzero exit value.
set -e

curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o $PACKAGE_FILENAME

sudo installer -pkg $PACKAGE_FILENAME -target /

# Cleanup
rm $PACKAGE_FILENAME

echo \>\> Location is $(which aws)
echo \>\> Version is $(aws --version)
