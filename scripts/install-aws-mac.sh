#!/bin/bash

# This will cause the shell to exit immediately if a simple command exits with a nonzero exit value.
set -e

curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"

sudo installer -pkg AWSCLIV2.pkg -target /

rm AWSCLI2.pkg

echo \>\> Location is $(which aws)
echo \>\> Version is $(aws --version)
